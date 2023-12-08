Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="hRz32W1e"
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C851729
	for <linux-pci@vger.kernel.org>; Fri,  8 Dec 2023 09:38:21 -0800 (PST)
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
	id 95E7D28C099; Fri,  8 Dec 2023 18:38:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1702057100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9jwYXd/+wLMsO7JUYvkKry9Yg6wKPuvC1XjJv+QENRI=;
	b=hRz32W1eyXu7m+0GOVIL1s13qgp6V9VREA7JYAg+65HWh0GUP4xUk7X1qQoPAm8IrUOSt+
	nw9//6QMQLqTiCNem9NP6xMhqcZZuKHdgpvak9Y6ZnCB2kkQaX5jnb/0CGq0WaAM8d81O+
	x88d5CHx7rvSsHaAKadws94f2gwH9lk=
Date: Fri, 8 Dec 2023 18:38:20 +0100
From: Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To: Nikita Proshkin <n.proshkin@yadro.com>
Cc: linux-pci@vger.kernel.org, linux@yadro.com,
	Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: Re: [PATCH 10/15] pciutils-pcilmr: Add support for unique hardware
 quirks
Message-ID: <mj+md-20231208.173733.30953.nikam@ucw.cz>
References: <20231208091734.12225-1-n.proshkin@yadro.com>
 <20231208091734.12225-11-n.proshkin@yadro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231208091734.12225-11-n.proshkin@yadro.com>

> +static bool read_cpuinfo(union cpuinfo *cpuinfo)
> +{
> +  FILE *cpu_file = fopen("/proc/cpuinfo", "r");
> +  if (!cpu_file)
> +    return false;

This works only on Linux.

Wouldn't it be possible to identify Ice Lake by PCI ID of the root bridge
instead?

				Have a nice fortnight
-- 
Martin `MJ' Mareš                        <mj@ucw.cz>   http://mj.ucw.cz/
United Computer Wizards, Prague, Czech Republic, Europe, Earth, Universe

Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6B13DB992
	for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2026 20:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783368765; cv=pass; b=b4Cny8GiqE39WmaA+mIGVI/wR4TgoneWQQ8KVAj4/Fkw+bOasGDGxWf2YrWFIgAcVVwR4lftVQGjPGztpHFZqjQiJRXxpVSCXEyu5U+Lieq58/gGzUKy1QMpHRuFullQpK3k7uOzbmHP6s4AYXccl0l03U7/wOG/9aHO7lGpQ+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783368765; c=relaxed/simple;
	bh=tCsl8rppV+5IzTQq6lB9+xMxhNa330FxUZBTap5O0sU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O4bTgjwkABwqBAneto2OQ7VgvIK4y1MjlJ2HzqfXNNC5ByjA6T/J7REKfuc9aIdqux2cwjl/MujZe/wcIOBrAhLSrpKD7+zQBiL6zta9hzpecl43u42c1kkqAI6iJRxKUrDq986st25cq8L+FGFMUCetGXdbpCiQg2FuBBS8om8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xpq1AdSY; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xpq1AdSY"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2caced6038eso2880215ad.0
        for <linux-pci@vger.kernel.org>; Mon, 06 Jul 2026 13:12:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783368764; cv=none;
        d=google.com; s=arc-20260327;
        b=nhRFgF11UzP2wXxuugx0pJKDr8XkbIK18lMJgy5tqu32c8SWuDliMpWXPlR3sySnKP
         6OjHIAIj9lv9VqQ4tuZdnSXQ3fmIqkJ0hOZOTWwrl2UVfyIqG25sfJe8pRHw1r9SBBSh
         A1cZ+LYUYUnpKnv4qIpEPc+VouykysRixVJ/j6jiYvsAS71lay3pGkG8qOx+jXgZL9sr
         qCvEpiV4fJCWk2tCvdtQawdsJ1ovxP6m9uaz336W5xK/+LTDJT12YcfMPrbr/LVeihoa
         J+//n3bQ5wiRN4KGv40zAj/M6wwtMaUOQPxZr1oq5s+2D/1PF3BCevrd1/LbeZ8mqMJk
         HaCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=tLsQwaAXDJNDfqHeYJY0yk7pXv8pT0EExTJ4qxzGluc=;
        fh=bEB760xBMSQcaz65V7Wc3wwwDCl7tCohlSGwQiYJsQQ=;
        b=UF3eeOz/ASz6t+WoEX0Tr7AcXC6nS7RtRsYq6L6FcpcvlW/z4c+oRw+jROPQK6FgaY
         c4kSREXBNo6QbUyEGQE3mlx9vN1IppJkHXthkJbQfnyqa0m0M8GivBe2/1B83bNNiA4C
         cVv+GMs9m0CZktVyB+UR6RmubHYaMNN+GYx1grBkDpwku16H5uUBCIzVX6jDVtqswrHA
         Xi5jjH7/GO9PyA8m+p9Vs6O2opk+tR/+efwtnnSQ+wdtVzNoj0MtuycvHKcURDB8qO9W
         bpFCkmfg4F/TpfqK7/yx83T7eQNVtaLliUVWnl5sNGtPAeJuZOKGmcfFCdyO3w4VwP79
         9UKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783368764; x=1783973564; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tLsQwaAXDJNDfqHeYJY0yk7pXv8pT0EExTJ4qxzGluc=;
        b=Xpq1AdSYaXtDkyuxK4DG8sO9At7N6K4VUGtojwRbXsu/TMusqo3bYFcy2n7lI1mxfp
         JA/usplyzRzkiekYBEhY1GJBDWUXXVYr2vut/N49Zrh6FeSOfe8GX8xApZXUl0eQP0F+
         0u20sOpwoE5dQGJYG0ywB6UwW74NcqZnScgsaCscZ4f8XKVPuIMDVxYAMfkAe8YusWGx
         I+gBpWyu0rzTC1jTMsXNBY6+22W5EIDO0N3Ry9WUlBFhrU33hbA5n4P+HGDl5ashuGaB
         t9NmJ8UavsFAa8mmkCFOkHoxjbhHkcqsKDffnxsCon23B621ZGeMKq7qjCa0kHOEITHw
         ficw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783368764; x=1783973564;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tLsQwaAXDJNDfqHeYJY0yk7pXv8pT0EExTJ4qxzGluc=;
        b=A9CfYlyNJl1MVhW+N5WW64EUx/JIvnOHlMuwithFYsB6JyK+mnk5b5B/YFOKSI2IOC
         BnnrwYyQWlCXaI5APGk8iPWEP525s8m6yannIJ/UezQ4CR4dYYf/XS+Oyipwotf28lRb
         DzokqOxTbYWnvdEUXhxzrvifTg2oVI8piX76hiV5WoBdnu/QxGk/xRFPEg3I/eUkhKDc
         h2fXgrVG9YREFEbly54tp04WNvCDQkyOotgsrg+3nNJduCzxHTTdHlQG1dsxXZZF781f
         mvW403MQEkIZyLnQMsQ35KvwGJL8ZtEPQr14yogmGz6mrzExeWL7ai1mrzCniUqzbOfE
         +8Qw==
X-Forwarded-Encrypted: i=1; AHgh+RprklIDaUwhHybOkMAuyxqv7hbV2ummZchi+kGcTqKEzY3FqYo53IRpE4INYNQNmrqdS+qKsE8ctak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc/K0AIG90wq2cAKvRh8i757OZLoC7+5RLlE9Re29x2yX6lg0V
	wwIFFd06M7K6ahuzyiBVfO54Pfq2rjAGI6D/sy5RaQ+brVznJ0frPjwa4PgqR5MeqZZlnZFFZgl
	QG21I3O78f/k0MJjVTzuqFsI565BKiJbql3r8CZw7
X-Gm-Gg: AfdE7cnHKdEKeShJpZHak1Vv5vu8GmfovSS9CBXe+qXjCwlKBRt/2SZC9sudEFDlATb
	Nz6zAPsdluLalZ1jOerw8c9U3mNip38XrfH1nU/A0FNkEDYmOuLs6/JKiMie86sGr/aYn3gDNP4
	q9F6/et1vpqFKe7HhA3hK3tIT7cxehPRjiNrd9eQ44Mf+7DTWbBqrbZfeBI19aDa+fTw0mlCEEg
	+VEFUM1Anbh5sldUOL6wifybZp99PA3YiYOn3dRr/zSNYvP5RKRcPjihc5SjRQ2VUwL4fvOst4i
	FW+zDgkSnwJlfK9iYVLn9YHptKutBKICxltAD+Eoa/3sVyEiMo+aydCb378=
X-Received: by 2002:a17:903:1b2f:b0:2c9:4163:269a with SMTP id
 d9443c01a7336-2cacb070123mr173926025ad.18.1783368763186; Mon, 06 Jul 2026
 13:12:43 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Jul 2026 13:12:42 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Jul 2026 13:12:42 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260327160132.2946114-17-yilun.xu@linux.intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com> <20260327160132.2946114-17-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 6 Jul 2026 13:12:42 -0700
X-Gm-Features: AVVi8CfMMieKOJ9KWV16RQIgCbb5IZwWCmKGZX-xsr03tKGnv5YmqnGOv8ZZx8M
Message-ID: <CAEvNRgGN=DPP27uMFCmaJu9pAdv4vj=XaG=ofhf1LfiwPZnoGQ@mail.gmail.com>
Subject: Re: [PATCH v2 16/31] coco/tdx-host: Support Link TSM for TDX host
To: Xu Yilun <yilun.xu@linux.intel.com>, linux-coco@lists.linux.dev, 
	linux-pci@vger.kernel.org, dan.j.williams@intel.com, x86@kernel.org
Cc: chao.gao@intel.com, dave.jiang@intel.com, baolu.lu@linux.intel.com, 
	yilun.xu@intel.com, zhenzhong.duan@intel.com, kvm@vger.kernel.org, 
	rick.p.edgecombe@intel.com, dave.hansen@linux.intel.com, kas@kernel.org, 
	xiaoyao.li@intel.com, vishal.l.verma@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Xu Yilun <yilun.xu@linux.intel.com> writes:

>
> [...snip...]
>
> +static struct pci_tsm_ops tdx_tsm_link_ops = {
> +	.probe = tdx_tsm_link_probe,
> +	.remove = tdx_tsm_link_remove,
> +	.connect = tdx_tsm_link_connect,

Since .connect is called from pci_tsm_connect(), which is in turn called
from connect_store, is the plan that the VMM should write to

  /sys/bus/pci/devices/.../tsm/connect

to set up SPDM and IDE before starting the guest?

> +	.disconnect = tdx_tsm_link_disconnect,
> +};
> +
>
> [...snip...]
>

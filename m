Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D611A6831
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 08:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.143.206.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779438192; cv=none; b=IehFXN8gVoGxICj4JzRmJbzhL6LxHzJd2zEfHjpsFgurLuxaVz1etjCcCo2nv/L3CQ4b6kkhO+wXtrdgeznv250FRd+Kf40NMnV01TdU3J3f3QGiamGaBfF9vaUGAuKbaSBRc/aXcEuadNPuC7+uHlLh8GkXGOAcuzhCtHJCIkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779438192; c=relaxed/simple;
	bh=b37zqEH3Nszaena/8hV8/INZkiB/hGjCYidBDXkS5mU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=anUNRjbr7dwCfCTLRsFHnFx6qY7fzqCTUeup2X3YcOQm3f3vALSmtWLdcPNkEim2zK7iuo83gxTdnwjeckNET4MUSGFmiZj8OhOBhs/OujK+p9B8lWbTxaxAKmkT4sDFdQRa2/51+IEy9DbvoC1x5ylJna66nJ7eTVl/1Ju43XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=118.143.206.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: 1X4TxFowS02F4aygJ19fOw==
X-CSE-MsgGUID: KdG9tI5SSMSLEqBGIeCSRA==
X-IronPort-AV: E=Sophos;i="6.24,162,1774281600"; 
   d="scan'208";a="150368649"
From: weipengliang <weipengliang@xiaomi.com>
To: Lukas Wunner <lukas@wunner.de>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	"Frederic Weisbecker" <frederic@kernel.org>, Niklas Schnelle
	<schnelle@linux.ibm.com>, Danilo Krummrich <dakr@kernel.org>, Uwe
 Kleine-Konig <u.kleine-koenig@baylibre.com>, Samiullah Khawaja
	<skhawaja@google.com>, Manivannan Sadhasivam
	<manivannan.sadhasivam@oss.qualcomm.com>, <weipengliang@xiaomi.com>
Subject: Re: [PATCH v2] PCI: Avoid unnecessary cpu_hotplug_disable() for non-NUMA devices
Date: Fri, 22 May 2026 16:22:51 +0800
Message-ID: <20260522082251.1819-1-weipengliang@xiaomi.com>
X-Mailer: git-send-email 2.47.1.windows.1
In-Reply-To: <ahANoSZXPFUX3HaR@wunner.de>
References: <ahANoSZXPFUX3HaR@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJ-MBX13.mioffice.cn (10.237.8.133) To YZ-MBX11.mioffice.cn
 (10.237.88.131)

Hi Lukas,

Regarding cpu_hotplug_enable() placement in the else block: would you
prefer it right after each rcu_read_unlock(), or a single call before
destroy_work_on_stack() at the end? The latter keeps the code simpler
while the critical section stays minimal -- flush_work() and
destroy_work_on_stack() are both short and don't depend on CPU affinity.

Thanks,
weipengliang

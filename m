Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.246.77.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795458225;
	b=O+j27YbK0EwUg7xAfyRSvH7s2aL2fbunutHV7DtOkPc/56U6xCszR0Oh3IPuwz5AJjwo
	 9A463K9ReCXbsjZ2dsmV7CbxyJK9EBJTaGdUt2vXLBa3qMf8V8h3XHpBXZWs4cWoDdDcb
	 lit7CYKjPN/RiwznKOEm+eJFlylHkClIK/AIPxMUaTNctzqWkqMhSgS4M2lE9cLfN4Axr
	 afD2iaFmzBj6cxlGb2xn4iAUpiEk6PZEqc6cVpVjJ5tUGh1vnYqRPgEhGW3XMB3LjCHi2
	 TrsMHFLGGn3pJ/HJisc5deWrUhHxAKiU/wB6lMAMiv7/KMsxXI82Rm7asoelT5ltjbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795458225;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=Kt4azeapA64VCSdaMF0zP/5k0GE4sGKBb1aJslbHe4o=;
	b=QMsC6K2mosMAcSZ8Nr+z8P8rXiaQ3LcFqGHXJXuGnjtaNOzqHO/votZzMecDHIF3bYlR
	 9GMXENwtGyUSDOh8ra1sXSX8VIGWUkyQj2K+JUAYXQRJTSGEupk0MrTxqs8RO17IxSItq
	 1AlXN5P6QoyJV3PCPB4Quh1olvjkzXtMbLFM2JDF+mllXvEkUF7X5OkKsEwE543rCkxi8
	 u9nT2IuDIRJHSv/Fh2ed1ZxJqvwhCLONeKEkZnM/FmNu5nvXV5e8/VAzCAbRmQtoHhaYE
	 r/pPcfPQDiA350ftQr8rMxj6AvP4H/O3kb5lrEzDwxDjvFhmzjxHZO5odp6URBoDRGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=Dlbv9P4o;
	arc=none smtp.remote-ip=44.246.77.92
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BB8606A31A;
	Mon, 23 Nov 2026 18:23:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08BB8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=Dlbv9P4o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1795458225; x=1826994225;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Kt4azeapA64VCSdaMF0zP/5k0GE4sGKBb1aJslbHe4o=;
  b=Dlbv9P4o5FdB6mlj5KxqMDf5IYgFbfHgVpbeC3YZetojcyUQvGKcs8tS
   ssVakYjf+6q5bmOtXEPR4/OpzeKoh/9moGpBNyaSSUv45972lM//iO+F5
   ruHPUXoTo4dAgfsjziTytUoCgoDePM1zxVJ0NkoYFfOaBn5MVo56mwMG4
   sO7gUQqUha6lCxneeDZx4JUoQDb1N7jQyLiX+go5KAgi0+2q0ZBj+2hX8
   x/bVwYdC58S2sbBi+bIpYKyeDik/6IsIUUl+IxPtCeQAeUjSEps2WqMk9
   e4E6FNvkoeoEuS0cAiQjshJhap5YlJD/vvBxw4X94DjOKV0YbE5lYo/Sc
   w==;
X-CSE-ConnectionGUID: k5SPLeHdSZmsePHRQCQjsA==
X-CSE-MsgGUID: wts5ZHTsRUS9COvnY4qKag==
X-IronPort-AV: E=Sophos;i="6.27,229,1787011200"; 
   d="scan'208";a="34884627"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 18:23:42 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:31260]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.36.204:2525] with esmtp (Farcaster)
 id 433428e8-8ea9-49bc-b01c-9534832f1596; Mon, 23 Nov 2026 18:23:42 +0000 (UTC)
X-Farcaster-Flow-ID: 433428e8-8ea9-49bc-b01c-9534832f1596
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57;
 Mon, 23 Nov 2026 18:23:41 +0000
Received: from dev-dsk-doebel-1a-7b355d76.us-east-1.amazon.com (10.169.119.5)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57;
 Mon, 23 Nov 2026 18:23:40 +0000
From: Bjoern Doebel <doebel@amazon.de>
To: Bjorn Helgaas <helgaas@kernel.org>, Manivannan Sadhasivam
	<manivannan.sadhasivam@oss.qualcomm.com>
CC: Lukas Wunner <lukas@wunner.de>, Konrad Dybcio <konradybcio@gmail.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION] PCI: d4c79b63d82d4 "Allow D3 for native Hotplug capable Root Ports on non-x86" silently breaks surprise hotplug on empty slots
Date: Mon, 23 Nov 2026 18:23:28 +0000
Message-ID: <20261123182331.132520-1-doebel@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261123144424.4164268-1-doebel@amazon.de>
References:
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Hi again,

turns out I missed that our colleagues from the ENA side already
submitted a series to fix this:

  https://lore.kernel.org/all/20261116165110.2773301-1-avivb@amazon.com/

I confirmed this fixes my observed behavior.

Sorry for the noise.

Best,
Bjoern

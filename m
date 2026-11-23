Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.155.198.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795450811;
	b=kWwsYFBronbtaUFs5p8RMmj8Pl21lX+Sqck0wrmnE7pYtSVSgNHcj2l+pORbGhKFi9OM
	 Hw4Y5C8sNoxonSxnDl6bv2q/DrrrQDbpwHgPmsoXJwCpPgqtSr9/TWkW2AtVLpot1PFMG
	 7biqhxVeShUF1KzFnf1IteOIA4Wjsp0yO/bPq0RU+5L5bWzY8ScODC0ffCwXJ2MESP97i
	 ieoGnMSJe4SS+hu99tmNd1TyIlLAXlW+CHfffWdrmPPSw25l68TGoVRZ5mwK7Bl1YDuV7
	 MQ4Z+caK4kBPS6PlemOMW61Ul55DIwTzwVc3e3E28BMYD7/C/KtR/tXyK13rhVd9MQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795450811;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=WacPhnHWjpSW9oV2WJtNqRk4Z2GjJVGHsagrSw8p4i0=;
	b=VvKnBd1/yClOW+r1CJeZiBgzXt9Dizk2ZYUe0Q2fddmFYE8cAFHJpVOJ4zzs9o4Q2sax
	 GuXHaJHIEbGV0+5RXpBIfqz1DdP9fqyGto3bIXHg7IkWGdVVT9Hw/2zcaljLEIYKEdRI8
	 MxQEOMPM8gJ2SgWnpPjP5uBMZKCydiKiGqHiSyPFiTh0uTc81gfBKtYqHd3Fd5OGxAc0V
	 NHUn7eIR/K6N0et9K5mrg0373c+l3zQpDFhjcZAK/D9nJA4gtpLbMSJpFAmP8T9EgrHk2
	 bKW8tqJt9LGDqzdQK23cPnsHtGAwLMjeltNZ6ZjcbSw10Ce/qCpL82UiYU5gdNnJD+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=ZPb1quOq;
	arc=none smtp.remote-ip=35.155.198.111
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F699606A336;
	Mon, 23 Nov 2026 16:20:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F699606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=ZPb1quOq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1795450811; x=1826986811;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WacPhnHWjpSW9oV2WJtNqRk4Z2GjJVGHsagrSw8p4i0=;
  b=ZPb1quOq+zka4SuA2N3b2rHzvIbTC/QoqFBfvA0tZtRgR7s0nhoS6AGa
   R52GiToz6CLPk/mKlaT+SPxt7FVE78Nr27zCn+4Pl06Hx6ghrlL/113er
   2NVlPHQamzaLSzLER3qXVFDSKIWMX4o5uq1H8qn4nq/0cEQZ+rqalitoK
   XoR5IhchaOd7A5QoKGezqZAyBiYeNBmbfuN9hMbA0zRfxtIME55qppZCf
   B3J0eJuIjnT2AbsJnzDmJC+6nGT3/cWhSzvO4qCTCmVpVTxif+zjnGoTJ
   YD+K8ajLYJNnLTq0idJ+Lzw97n+2iJzFo98f+Tas0wz88TdTbXVeqbrf+
   Q==;
X-CSE-ConnectionGUID: 20j9gBo5Tg+T6iXmFB3Bjg==
X-CSE-MsgGUID: x0SdqDL7R06yG470JpSEbQ==
X-IronPort-AV: E=Sophos;i="6.27,229,1787011200"; 
   d="scan'208";a="34833635"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 16:20:09 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:5629]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.36.222:2525] with esmtp (Farcaster)
 id 7e935b20-9c49-48b8-8da7-fda9e8922f09; Mon, 23 Nov 2026 16:20:08 +0000 (UTC)
X-Farcaster-Flow-ID: 7e935b20-9c49-48b8-8da7-fda9e8922f09
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57;
 Mon, 23 Nov 2026 16:20:08 +0000
Received: from dev-dsk-machaujo-1c-d6b511e2.eu-west-1.amazon.com
 (10.253.100.8) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57; Mon, 23 Nov 2026
 16:20:07 +0000
From: Joshua Machauer <machaujo@amazon.de>
To: Richard Cheng <icheng@nvidia.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
	<linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>
Subject: Re: [PATCH] PCI: Skip the CXL state update for a VF
Date: Mon, 23 Nov 2026 16:19:56 +0000
Message-ID: <20261123161956.72689-1-machaujo@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <awOxn3BcKl8Ru-QS@MWDK4CY14F>
References: <20261119164219.51540-1-machaujo@amazon.de> <awOxn3BcKl8Ru-QS@MWDK4CY14F>
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
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Mon, Nov 23, 2026 at 11:29:10AM +0800, Richard Cheng wrote:
> One nit on the sentence above, before this patch, each VF add also re-read
> the Flex Bus Port Status of every bridge above the PF.
> That refresh is now gone. I don't think anything depends on it, but
> it is a behavior change, might be worth to mention it.

[...]

> I would like the spec section to be cited here, CXL r4.0, sec 8.1.8
> "PCIe DVSEC for Flex Bus Port"

Thanks. v2 states the dropped refresh and cites the spec section in
the comment.

> Is the walk to the RP needed, or would refreshing only the immediate parent
> would be enough ?
> If it's the former case, we can cut more cost for non-VF devices too.

Refreshing the immediate parent looks enough to me. A device is only
visible once the link to its parent's downstream port has trained, and
the links further up were already read when the device directly below
each of them was added. The link speed in pci_bus is handled that way
too: it is read when the bus is added and updated on link events
(retrain, bandwidth notification, hotplug), not on every child add.

I don't have a system with a CXL switch to test that change on, so I
have kept v2 to the VF case.

Joshua

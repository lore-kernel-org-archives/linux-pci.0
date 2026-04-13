Received: from mailo.com (msg-4.mailo.com [213.182.54.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585C51684BE;
	Mon, 13 Apr 2026 21:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.182.54.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776114123; cv=none; b=qkBpRl5xLGXirNbSh8+YUYxh+bVl9WzDe0mjk0Cwwx4hbfhmc2yD2wX2XkAyO21RvRYVRKCZ6vHrvk7Dl3TF45p79oO4M+/R4IalCvnOsvmuI0m8OiMpU2hkb++br7/HhLm/025gjn4pOZK3k89Bf45slA4ORz2XpHsSL7jCDpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776114123; c=relaxed/simple;
	bh=hbUx6wNUVFIBL0riEmOo71hwj9mxDRrI3TfvywgXYS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z/0viWZVxAXGPPqtfPMWL4e7fRcrGToNbf1kkwlchfmcup1L2Et6E4JPo94p6koGYHruESB9cDRKbXQPsQpwVj1BSp+27kaKU+F5itxtbRIbUJ0fWJK0e9Gd5F7AEW2/4cS3tbhTxmaPIMlfHIj02P31I89xWYDtGVo4y53dwJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mailo.com; spf=pass smtp.mailfrom=mailo.com; dkim=pass (1024-bit key) header.d=mailo.com header.i=@mailo.com header.b=Ngfzl99O; arc=none smtp.client-ip=213.182.54.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mailo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailo.com header.i=@mailo.com header.b="Ngfzl99O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailo.com; s=mailo;
	t=1776114077; bh=hbUx6wNUVFIBL0riEmOo71hwj9mxDRrI3TfvywgXYS8=;
	h=X-EA-Auth:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=Ngfzl99OvGVBH+WUSMkd/1JXIC+bDXr6/JBY1dlQhdnwqd3C73gtIOsMqKupQW1Q7
	 Ty59lZl0W6/D5/I5eMjjoVn/zwDes4wk1z4ULyro+y7DIJnHddaUpWLDbffQeedG1z
	 bP0T2Y1OKLIv6R4R4fN+CNmeWv7JGf8AmU+uPbsk=
Received: by b221-3.in.mailobj.net [192.168.90.23] with ESMTP
	via ip-20.mailobj.net [213.182.54.20]
	Mon, 13 Apr 2026 23:01:17 +0200 (CEST)
X-EA-Auth: CjGjc9XK/riHuev+p5oUVSiwLJkFBMWQc7nfWyFUmhuKZRE8BA+1tHaEN5EV1RsVbnRlWrkywfHdxxfbAEMEo0IWby/cD9ouL+eg87purIcYaRlgxuCH0A==
Message-ID: <f55cb406-4a49-462d-b933-48303b32c014@mailo.com>
Date: Mon, 13 Apr 2026 23:01:17 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug#1131025: [6.12.y regression] Regression with 58130e7ce6cb
 ("PCI/ERR: Ensure error recoverability at all times"): echo vfio-pci
 >driver_override does not work for DVB Adapter
To: Lukas Wunner <lukas@wunner.de>
Cc: Bernd Schumacher <bernd@bschu.de>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@debian.org>, 1131025@bugs.debian.org,
 Salvatore Bonaccorso <carnil@debian.org>, Bjorn Helgaas
 <bhelgaas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>, regressions@lists.linux.dev,
 stable@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <aclRwznwq6KpA2qA@wunner.de>
 <177373189751.7987.7156982489427825197.reportbug@obelix-trixie.bs.de>
 <ecf9b2dd96ff97cc035ba297266b8dd05eea88da.camel@bschu.de>
 <ac0Y85OShbK6mHEV@monoceros>
 <8275e5b86696dec133889713258c2e158a443496.camel@bschu.de>
 <ac19pxEZKvQuQwFV@wunner.de>
 <7173609c404c5444e634dd3ab26f55f2788d82e4.camel@bschu.de>
 <ac_VqcBbKRDkHp69@wunner.de>
 <79618160f928d7ed4ba0a84f3ab420427c5b8d10.camel@bschu.de>
 <dd3c3358-de0f-4a56-9c81-04aceaab4058@mailo.com> <adxlr9lWBTZIQMev@wunner.de>
Content-Language: en-US, fr
From: "Alexandre N." <an.tech@mailo.com>
In-Reply-To: <adxlr9lWBTZIQMev@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/13/26 05:40, Lukas Wunner wrote:
> Could both of you, Alexandre and Bernd, give that patch a spin
> to see if it fixes the issue?
I confirm that your last patch alone applied to 6.19.11
works in my case! (no need for 4d4c10f763d7 nor 907a7a2e5bf4)

Now my host and guest behave like on 6.18.9, including removing the
pci-stub.ids line from my kernel command line since the automatic
handover between ahci <--> vfio-pci is working again.

Thank you!

Alexandre N.



Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E5329BDBF
	for <linux-pci@vger.kernel.org>; Sun,  8 Feb 2026 21:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770586259; cv=pass; b=W06Q9cVsTIMhD/Eci+ubh0PVbxxmboExN1s8g/QB751ej9tJsWGFTMa6hXUw0lPS/4/6GSi8xwcl0CqpqEYKA6iTlYEQqR5vfDA5CI0zHBD+QzUA1hvybvRCbh90NcqT7QSimrDFEMKcaxdjiGRkRjhiWddcUYdBQofdrJyGhqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770586259; c=relaxed/simple;
	bh=DqBLUrhBuL06YYsO+DzU6rbEovOYWHLh4Pm3Ji3ddFM=;
	h=References:Message-ID:From:To:Cc:Subject:Date:Mime-Version:
	 Content-Type:Content-Disposition; b=qLTTo6COTXTBcV1eKCEe9kyp+yCu85OwJr4+6MAO58PiYT4qd5439WlkkDUUSewRslgMV+VLbuZE0EgyEPkLSEKNcaOiDvz8wgkFCbbTiAerZ8ZnaKU5xcTkmjtYch6faZdTfQhO3bLpIFecDEfnS0dfy6Ihv8Jx+kRhcADMyO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=masysma.net; spf=pass smtp.mailfrom=masysma.net; dkim=pass (2048-bit key) header.d=masysma.net header.i=@masysma.net header.b=nm4C4Y0E; dkim=permerror (0-bit key) header.d=masysma.net header.i=@masysma.net header.b=WzFDkwjw; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=masysma.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=masysma.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=masysma.net header.i=@masysma.net header.b="nm4C4Y0E";
	dkim=permerror (0-bit key) header.d=masysma.net header.i=@masysma.net header.b="WzFDkwjw"
ARC-Seal: i=1; a=rsa-sha256; t=1770586241; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=HFIDYRQ8KCEJiCeQGSXvFjjlAFNO+NeTl8isRM74yaMEINx12xFt5bgtbdM2tMdU/S
    07aLxiWdSl3Z4ODly6tenNF5U7MBaB3sne94zpsukJMQMq4PtnjCkaRP3Pb+eeVBO9U7
    XdhGGSUTrVnnJnCzv2VbmeMvYeU3J444qneaIvenwb+zwK+R3ZTYOV7aLQgewkGC5imI
    evyw0SHJeaZxrNEm5oyF7VRzqlZWqch84rX5NKwSJ1sPEJYYRgwP5S/6uYJLWO8Q3mPE
    oMShUddGuA0YDDM7xaiQrMa+qX0Zcwpx+rSe35KxTqR0ASYseq1n/4az7W56zASpgtOa
    18Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1770586241;
    s=strato-dkim-0002; d=strato.com;
    h=Date:Subject:Cc:To:From:Message-ID:References:Cc:Date:From:Subject:
    Sender;
    bh=+O44CNWrLoa/XFnBV8A7kFFREAVFWtrL1ZCd+Xie11A=;
    b=jJQAo+wL+RcUD/o4MV3kU5FcjpVZC+4pFyL4un4Y9kpOaO2kP09tRg07teajqLmlYT
    S4/hPa9e4rH02mDumqvUvEoVxgsbhusKb0HzLL+h3dgoihj1FsUDpsvNm9N9BdF7EjBx
    2x3JP9F0A7toPP8US9GdIBdHiR8wbF2NoKYg65BxWkHLw6U7t27r8wLm4kA6DVTElRU0
    w5NBl9IIW8AYzjE3CU/l5FI+YrsJTQylhqDJ4vWdu2AEJ8dDPDb4JswNGiDM99cxgtu8
    z5ynKkiTRz3ziZWGPiAmcwUjc2d7M0va/so328HHvJGZOPiYeeQ06/k3B5rXcvz1HYQs
    o8Tg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1770586241;
    s=strato-dkim-0002; d=masysma.net;
    h=Date:Subject:Cc:To:From:Message-ID:References:Cc:Date:From:Subject:
    Sender;
    bh=+O44CNWrLoa/XFnBV8A7kFFREAVFWtrL1ZCd+Xie11A=;
    b=nm4C4Y0E0omdMrIjIeZUhSDDjowW6QFBbpaApgb+A7lFh5oRIdv8Zap2nBzudi9Ct9
    hzYaRRTQJdtYvMTbPK3a6+G+5GKWj7zRBclmaMPBZubvHRuC4msKYb7L7bYCL3cBYBIl
    ZPLYEisGq4mrSM2TKxlVfk6iM8oeplQTkq6yL3VjVasltFDiaBQyJYI8ct4OkfBpVCFK
    KKb7gTTUh1ARoxB08NBqhL5DOOFIdEmluiRcqzlHMJNm/YPNE8JKjgEo86G+RfQi66gy
    rUH2qaUIAMxH51YqGabztbwA4vsb0dSo1y2aaBPMYUV16j7g5OWiM+mT0TLUvxMA8uwo
    arqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1770586241;
    s=strato-dkim-0003; d=masysma.net;
    h=Date:Subject:Cc:To:From:Message-ID:References:Cc:Date:From:Subject:
    Sender;
    bh=+O44CNWrLoa/XFnBV8A7kFFREAVFWtrL1ZCd+Xie11A=;
    b=WzFDkwjwjKGVON5rNZ7IpUxCW38KdE+58QBOtD1Fc0v35Df/U7y94CZe3nREOmgp3X
    TdtNIUfiCUZohNmVhZAg==
X-RZG-AUTH: ":JWICemCleuxmQC700vpzGgDMhu8YP6Ql4e3bvdBvsQ2fC5IJhh3tj/mdIDjDL2XEF3B/cogzjlgx+bvlDJMMOb0rK2YO2Wo="
Received: from masysma-18
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id 97fea1218LUeE0j
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 8 Feb 2026 22:30:40 +0100 (CET)
References: <20251008165345.GA627277@bhelgaas> <80340269-c702-442d-a461-300a2041a497@leemhuis.info>
Message-ID: <cone.1770586239.550948.1302334.1000@masysma-18>
X-Mailer: https://www.courier-mta.org/cone/
From: Linux-Fan <info@masysma.net>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Hui Wang <hui.wang@canonical.com>,
    Nirmal Patel <nirmal.patel@linux.intel.com>,
    Jonathan Derrick <jonathan.derrick@linux.dev>, linux-pci@vger.kernel.org,
    bhelgaas@google.com, raphael.norwitz@nutanix.com, alay.shah@nutanix.com,
    suresh.gumpula@nutanix.com, ilpo.jarvinen@linux.intel.com,
    Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
    Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH] PCI: Disable RRS polling for Intel SSDPE2KX020T8 nvme
Date: Sun, 08 Feb 2026 22:30:39 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Linux regression tracking (Thorsten Leemhuis) writes:

> [top-posting to facilitate processing]
>
> The issue discussed in this thread is still on my list of tracked
> regression, which got me wondering what's the status here. Did it fall
> through the cracks? Or was the regression maybe fixed already and I just
> missed it?

Hello Thorsten,

I saw the regression was closed here:
<https://lore.kernel.org/regressions/e03d4af5-5cdb-4bf4-a568-06b9213247a0@leemhuis.info/>

I am one of the users affected by this issue and are currently running an  
old Linux version (Linux 6.1 from Debian oldstable) to work around it. As a  
user I would very much appreciate an upstream fix.

The Debian bug is still open
<https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1112238> whereas I think  
Ubuntu got a patch working around the issue for their users:
<https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2111521>

Is there a chance to possibly include the workaround in the upstream?

As the issue is reproducible on my system, I should be able to test some  
patches if necessary. Tests are not easy to perform because it degrades the  
RAID system and I would like to avoid damaging my “production” data hence  
limit the tests to the required minimum.

But if there is some real doubt that the issue is still present, tell me and  
I check it again with a more recent kernel version?

Thanks in advance and Kind regards
Linux-Fan

> On 10/8/25 18:53, Bjorn Helgaas wrote:
> > Nirmal, Jonathan, can you confirm that when RRS SV is enabled for VMD
> > Root Ports, we should actually see the 0x0001 value when a device
> > downstream of VMD responds with RRS?  From the log below, it appears
> > that we actually get 0xffffffff when reading Device ID after a reset.
> >
> > On Thu, Aug 21, 2025 at 11:39:36AM -0500, Bjorn Helgaas wrote:
> >> On Thu, Jul 03, 2025 at 08:05:05AM +0800, Hui Wang wrote:
> >>> On 7/2/25 17:43, Hui Wang wrote:

[...]

> > The patch is here:
> > https://lore.kernel.org/r/20250701232341.GA1859056@bhelgaas
> > and the log with that patch is here:

[...]

Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4CE4DDB46;
	Sun, 18 Oct 2026 21:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792357826; cv=pass; b=aKDJjXH0Blvx/hbDowVI7n6TIoIzwtRgusitMHMqSZnMwdFbL95PyB0edc46/bK1azfbl81QDi8HwociTFLwFLhgjo1JoKn7YFvRx5Apo+suBAGJSOn1WGwrwS4tMct4Y2WFOTOCQScP3H9IzIYVJ6Rh0hs8oUi6RWpUH3IYpdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792357826; c=relaxed/simple;
	bh=3h/FBrbM+VFwW0h7C0SNF3vnnNQcYz9uoB0zA6hvT2w=;
	h=References:Message-ID:From:To:Cc:Subject:Date:Mime-Version:
	 Content-Type:Content-Disposition; b=PUGmX3XMsMnRUwdskpp7qUM/SC22DcbsSodOA62pHpqHSoDuj1UlL+Paa58+nYTzIqGBo9Z/AQ8Adn528UljtzKWm242ttO3O/zZ8B+03Cs4NnEJBIj6E4+8L8D+YOZ0jN66gud/nET+i6qXTOMXM7D5tDuqRzKtW9YeMqvRUsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=masysma.net; spf=pass smtp.mailfrom=masysma.net; dkim=pass (2048-bit key) header.d=masysma.net header.i=@masysma.net header.b=kngLy2/H; dkim=permerror (0-bit key) header.d=masysma.net header.i=@masysma.net header.b=YDLtR2vh; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=masysma.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=masysma.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=masysma.net header.i=@masysma.net header.b="kngLy2/H";
	dkim=permerror (0-bit key) header.d=masysma.net header.i=@masysma.net header.b="YDLtR2vh"
ARC-Seal: i=1; a=rsa-sha256; t=1792357810; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=n0AvXHFGsviuQ+yv5HvyL7MKapVJksixuDmq9FSPm4VFfpPREzvdEznqt+bBKlLv/k
    gc+0HDG/WuhNfg7Jm8EN7UqwbZfeXj3xUuCDlXwMbi0x8TQtZezrF/AdaLKgXEkMy9Wj
    PvefcFCedWSqhEiL/6XutNcODwohD/LtgSGxTSOqd06ac457jczcSlmWe8OLyawylTvS
    yd2j+9N+Z75Ww8XsiLcL9Aj23wfemY6Jw8j6XLrSCL9Mg12rIS2VzjfJj38Ef1nJAewq
    JUwWzLaDqdbT+xqSt8/054FpUMbi6PKFUf66ynOXINkFd+TYIC2vp5N0JDLvzSU7/x3I
    jb2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792357810;
    s=strato-dkim-0002; d=strato.com;
    h=Date:Subject:Cc:To:From:Message-ID:References:Cc:Date:From:Subject:
    Sender;
    bh=4954EnejhVUQZUG7uW0CVBgNR7C0Z2q+7UdrvuCAW2w=;
    b=XyTb7ZEs7w3w+pAVp3ysDEtrYspGijLQmWHV6v/uNIKZmm1PHNrI98IcbCBmrKii0/
    i1IpevHka7HwMpp53o1gWCILXpTkxP0Reu0eS2YNm9xv7Ei40c9JjxLTrts7zJ880HQK
    BXqCZbNhnp37J3djpKOV31rDCAwWsIpJaS72z4Pb9DhT0pv3EBNrNLADJNSGdagByAkr
    kdlBp5cWARU+pWAuD74K8FbUFymRHMPjDcb57m6PDiSY+Jb/CNabuAABQGyRL+47nONn
    dHPBK+yu3Yq0MmsYVJvO04i/vr3bme9BFM5GXgimx2+9WsjHQEqQDLMEsLNZIhCmeVPY
    kKPQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792357810;
    s=strato-dkim-0002; d=masysma.net;
    h=Date:Subject:Cc:To:From:Message-ID:References:Cc:Date:From:Subject:
    Sender;
    bh=4954EnejhVUQZUG7uW0CVBgNR7C0Z2q+7UdrvuCAW2w=;
    b=kngLy2/HCUUoQhAVqGL3Q2HCW7OCeWcLGKodVcmXQJHDYVwE32RTrvwXkSgEb2Q3JD
    s5Wo8KWWrtnpMuYKB8f+U5WAhMHxUurL12LiL9rfYRy1dMdmr6bBEqkSIfNoGmEWlvHt
    iLAMuVLF3kwd9ndQhMU444FJRcUkHr/dvnODAt/W3Gzdn03SkH6nOTgN3SgciQlUkvbA
    ZTj1RZEfMIkDOnIe6xmfqV3cvW3YR0JRMg6efx1RTCGq9C0qe13+rFaxJptaS5Xe7imu
    1lzV70SIUzqIYlgftLHVCIDs0+4OiorrsIqFu+MptMR12dedXeBjykaf/q2xMxZ+a0Q1
    teUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792357810;
    s=strato-dkim-0003; d=masysma.net;
    h=Date:Subject:Cc:To:From:Message-ID:References:Cc:Date:From:Subject:
    Sender;
    bh=4954EnejhVUQZUG7uW0CVBgNR7C0Z2q+7UdrvuCAW2w=;
    b=YDLtR2vhCiMEMqb348g/b56gH9B50BWxM26Fno8M29RBp4PQk+23AL+k4DLKKzttqr
    lP92M+JnJL6icNRXTFAA==
X-RZG-AUTH: ":JWICemCleuxmQC700vpzGgDMhu8YP6Ql4e3bvdBvsQ2fC5IJhh3tj/mdIDmcLzDOhHH2a/syK0FsdBnAYoP8O618xjTxmvs="
Received: from masysma-18
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id 9b2d4129ILAAYQD
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 18 Oct 2026 23:10:10 +0200 (CEST)
References: <20261011163249.18479-1-gruhlke@mailbox.org>
Message-ID: <cone.1792357809.260300.12734.1000@masysma-18>
X-Mailer: https://www.courier-mta.org/cone/
From: Linux-Fan <info@masysma.net>
To: Alexander Gruhlke <gruhlke@mailbox.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
    Rafael J =?UTF-8?B?Lg==?= Wysocki <rafael@kernel.org>,
    Alex Williamson <alex@shazbot.org>, Hui Wang <hui.wang@canonical.com>,
    linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
    regressions@lists.linux.dev
Subject: Re: [PATCH v2 0/2] PCI: Wait after FLR for devices that don't honor
         Immediate Readiness
Date: Sun, 18 Oct 2026 23:10:09 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Alexander Gruhlke writes:

> Since v7.2, VFIO passthrough of a Samsung 990 PRO NVMe [144d:a80c] fails
> on the second VM start, and the device is inaccessible until reboot.  The
> drive advertises Immediate Readiness but returns ~0 for up to 7 ms after
> FLR, so since 10baa9b4df40 ("PCI: Drop unnecessary retries when restoring
> BARs") the config restore after FLR is lost.
>
> Patch 1 ignores Immediate Readiness on that drive.  A 990 EVO Plus
> [144d:a80d] reports the same errors [1], but it isn't confirmed to
> advertise Immediate Readiness, so it's not included.
>
> Patch 2 is independent and keeps pci_dev_wait() from treating ~0 as
> ready with RRS Software Visibility, which also affects the Intel
> [8086:0a54] in the open d591f6804e7e regression.  Hui, Linux-Fan: testing
> patch 2 on that drive would be appreciated.

Sorry to be late to the party -- I only got access to the machine which  
showed the issue today.

I have applied the following two patches:

0f8b5d90d179 ("PCI: Ignore Immediate Readiness on Samsung 990 PRO and 990 EVO Plus NVMe")
e8df1d194c39 ("PCI: Don't treat ~0 as ready in pci_dev_wait() with RRS SV")

These resolve the issue for me.

I an very happy that there is now an upstream solution to this, thank you!

Kind regards
Linux-Fan

[...]

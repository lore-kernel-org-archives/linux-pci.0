Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7078378D92
	for <linux-pci@vger.kernel.org>; Sun, 26 Jul 2026 22:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785103702; cv=pass; b=Z74SNGQoIBbs72WyDIsFYpW7Il8bEf2GG/QjjkmgRZ3Isu0a07EsaBUEksjVjOP8HBQLjKVv/FtFlsgHwB61JsxGH0stAtl/beXcNbdYatQahnSG53aPcgGDg2dwvkWuMxHQrOdeZWyjz/FBc+HJiB+eroRjch7SBOe5Ob+1K68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785103702; c=relaxed/simple;
	bh=l6kuW7tsuMTlc/cnQDDYO1jjYAQDL3c70iHbRdCm15Q=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=HiRtHoqPdTA1F58WGdWh6UzuyaCgXdWTdwJrcTEwWLrryU2Ye9eQ/rdkGOftG92/SONJWZGeaFpI3lXlXHuwPuM/+YUCypW9GmI8uWvXXpzDPbz7sPwnZc5VrlgDgvcRtDuxxr4kQhqm/L73bXeJpfjr18bbea7ryeXLWy6WpdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ycwlmhbp; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ycwlmhbp"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-39c8dbf4f38so18407401fa.3
        for <linux-pci@vger.kernel.org>; Sun, 26 Jul 2026 15:08:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785103699; cv=none;
        d=google.com; s=arc-20260327;
        b=WNIWRLbDjf8irNIAH0Ms6tUcRUzbpa/2IaPZ5hKlNNG8GS7eSibFhofeIICZAN/weE
         juRi9C8iJ6kExSFrUcqP0UpLMzCV4+8zN5Iu+yy/4MciI46jTm0T0KsFVYCxHKU1RbTn
         z5vIyaOKOlVVZUFyJUzgnQywNt7BnnVNqrsLZL4/QR15tdIKO5ce8GQ2I3Dpxf2EAsVo
         /eqQhkdLgxJERoQkt9Od6yJLAbJGwdIspqjwqlGo0eGNh5eumhd5dWNEZsWO5P2nQscw
         AvAWON5488pJ1XJU0uRyz+3x5HYiokbzmF4uozpAXpqmCtSwQy/cL1d7RKq8Lr+1v1U1
         NbsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=C1Mpd7IYtVtKabiAR4vX08BlgzDtp3z9nxc1grOLFSc=;
        fh=iwIYc5YLyaolT9jF8bO2LvY8t2lfMsnsLDCh7xn9JJE=;
        b=jE4cM/MMEWwXV+3rxqDXzXGH9eKGoJgmahQIxqLMkHkYAsvGnP6l4RXw0nOgnGZ/b+
         MfklxxTOrzNaALyva763j2fAxEV/vVmD/hgDGKMq/WoFu47eJeAQ/RrGZ//3NqYtdKuj
         GH6IMqJXNd7SKX1kFzsMgW71eCNe2pX4Y1nnZeZMVXw0RulPTTyJSNPgXAeh8d4uCwZw
         E9ZT/KSk+zl/D/QeEdfj/Y0zYiOY9VMnIZ3SKN4KFEMY3iF1rA7pns3I6wKCo4NWq7ZI
         gdITCNrKLWb+SU57DHXQfm6ASaq9R+WPqVDcIhpb0r2dvxLkpidItPFcVS1YsCKwuk72
         yGtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785103699; x=1785708499; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C1Mpd7IYtVtKabiAR4vX08BlgzDtp3z9nxc1grOLFSc=;
        b=YcwlmhbpisaQEGfF7My4HieneIvV5wgoXZblOCkVk68mci0B+jzxGjK1McUHgjSxhy
         5YKXS/nUkgNH6XACpE1hIWunpLWMOJ/faMjvHzavOe6dx8WlcYqzZZO1Zps0/MenfDW/
         ExyNZAxjVfkwuu9XU2ctwJhq1wrSIf5r1YPJJt6nw3aOrgXagTdqkhyQR4yPgxn/UDSr
         ccLEDzxeeFWkaAGL38ij1dOSb2X5KVZbGEtZYcUA5gpk7R7FT6jxGOuEbg6TxYtvY3km
         rpYCQqneV3bqDpWSDu8ijkhRBGFgHBKOJMeUgY2ofcFolHtDaPfomj1TPpSEtsSWVCBA
         ZUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785103699; x=1785708499;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C1Mpd7IYtVtKabiAR4vX08BlgzDtp3z9nxc1grOLFSc=;
        b=kpHZLsjTATgiJb2msnKBY4nZH9vQn2cJhPO3yHVr/juITbgmNaRaW/JZpCROJlLLQk
         Iv6BPZyaXcIzp5TvINSVdvfBVsOe/Pk2vCagSoha1/sDf+AQnm4kbZjlRvf+Q3uNHGc0
         E0gMkOCOfyd3Dni55nCV2Y2StW5j5wl6bRTFiSNzIpi8nNEPeDPb/0s+zaOKJyX2LGZf
         ylX2wTSO6Be9toev3DzY5ICN3n0HLIJjM1XBmjioPPpdWorXJB0lqOAJNrAupGIK7Jop
         ezjyK37Rc4tG67mZjGOTYKyI5rqO/n9nFCUvaF6SZQNTRh1OoqZNeBojBZ1+mx8JHtM/
         fwww==
X-Gm-Message-State: AOJu0Yxi1m6xUQGf/YVdM5XmsZ1zpD53ObDaLig5FjqVm9gTLHBdfaTv
	KJysUPBbK5Ptw1bqRCTighNJrDKBdWYSR5Bo2DMNb21VOJuDLsSS0Z+swmgyJFcqzSjp2APSD0X
	w7vEaW90NkvZhgqLTUJLl3sbzJbOITb/k+Ji/ljs=
X-Gm-Gg: AR+sD135MKsXwL/zFDbrhkxioc1s5UhO5ZTfxsMTEoj/fNnS5F8hfD/j9zjVRZz6DX6
	5Ox0orCsv73ETiYI+Jn6bOLJ5y/UcAEZyOH73QlVruZ7sq4BHxt9W//JlI9GUYAWeXCZvx1qYsh
	DoHPXnRRQ56LqNrV/JP3DohrlyqiqibNz/lQ+KqJO9rOL2AiKwJxJ1Yq4amRgrLQXXE44ofBP1y
	Z5y9+3G4sBiyMzoQhLJAgqvnDGxr05Tt19MBaA8PzBMYZvwrIsz+BliDjMv1qzRdJ5VvqgxuA3Z
	zrraB/8c/j8HFW5WLSx0oRkNuiPu3ELDHkN1444sGRI=
X-Received: by 2002:a05:6512:3c96:b0:5ae:c745:f39 with SMTP id
 2adb3069b0e04-5b2c1b48005mr1192173e87.44.1785103698614; Sun, 26 Jul 2026
 15:08:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?0JDQvdC00YDRltC5?= <deviljindante2012@gmail.com>
Date: Mon, 27 Jul 2026 01:08:06 +0300
X-Gm-Features: AUfX_mw6dkuhQgOYx77WFnKdvuce7vwvntcoGxFygwAwjNQQlSH-GRxs6SHsmoM
Message-ID: <CADpSnWCm73owOh=F=jQTqsLvsBCpF0Lrq_mqYRXjnKsSUp8NNw@mail.gmail.com>
Subject: PCI: ASM1166 appears to require quirk_no_bus_reset
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I recently ran into an issue while trying to use an ASMedia ASM1166
SATA controller with PCI passthrough (VFIO). The controller could not
be successfully assigned to a virtual machine.

While investigating the problem, I noticed the following kernel
messages after a bus reset:

pci 0000:01:00.0: [1b21:1166] type 7f class 0xffffff conventional PCI
pci 0000:01:00.0: unknown header type 7f, ignoring

I tried a number of different approaches before eventually finding the
following Proxmox forum discussion:

https://forum.proxmox.com/threads/problems-with-pcie-passthrough-with-two-i=
dentical-devices.149003/post-852041

The thread describes the same issue for the ASM1164 controller. The
proposed solution was to add quirk_no_bus_reset, which was later
accepted upstream.

In the same discussion, another user reported experiencing the
identical problem with an ASM1166 controller and was advised to try
the same quirk for device ID 0x1166.

I tested this locally by adding:

DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ASMEDIA, 0x1166,
                         quirk_no_bus_reset);

This completely resolved the issue on my system. The controller can
now be reliably passed through to a virtual machine and survives guest
reboot and reassignment without any problems.

Test environment:

Hardware: WTR MAX
CPU: Intel Core i5-1235U
Kernel: Linux kernel 7.x
Host OS: Proxmox VE 9.2.5
Installed controllers: 1 =C3=97 ASMedia ASM1166

The issue is reproducible 100% of the time without the quirk and
disappears 100% of the time after adding it.

Would it make sense to also add the following quirk for ASM1166?

DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ASMEDIA, 0x1166,
                         quirk_no_bus_reset);

Possibly by extending the existing comment, since the issue appears to
be the same for both controllers:

/*
 * Reports from users making use of PCI device assignment with ASM1164 and
 * ASM1166 controllers indicate an issue with bus reset where the device
 * fails to retrain. The device does indicate PM reset support
 * (NoSoftRst-), therefore this still leaves a viable reset method.
 *
 * https://forum.proxmox.com/threads/problems-with-pcie-passthrough-with-tw=
o-identical-devices.149003/
 */
DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ASMEDIA, 0x1164,
                         quirk_no_bus_reset);
DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ASMEDIA, 0x1166,
                         quirk_no_bus_reset);

If any additional information, logs, testing, or confirmation of the
issue or the proposed solution would be helpful, I'd be happy to
provide it.

Thank you for your time.

Best regards,

Andrii Zaitsev

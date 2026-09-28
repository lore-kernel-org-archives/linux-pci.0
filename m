Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EE13C276E
	for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 18:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621899; cv=pass; b=YOBfhHGZvHC7riXmvNcarr1TozdoJ3PLoyQAQxBEt63acMkphq0pzhiBA3zi+aak3xn9jwhZEIMvJz/9arcjkF9FZjBsLN0WwKmJpoCoUGtHGE4x+IwmysaJCHE3apNCvXHHmMc42sWV08jKs3O+PaHbyrHk+G7cIntaoG/najo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621899; c=relaxed/simple;
	bh=EdVeXkgV9pi4EO1zLlRvey2I1xuy1Dyo+nGExdr17w8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=IZbhnXE3OKFeKfIW8zDVg5EkSXIZz09ss6gMEd14z9NwQWuExSLVcYrgSFzhKFhtDh1h/FiaZBNx7aiFVjJL2VIr0O3OWsVVkc71YxhO41G/WxqYKdqTZnVKDMbac/se1tRnSzNjBCf6sKJ1Gz6pZNAnoTx3FexoONgPzcLqiHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbY8/wlr; arc=pass smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbY8/wlr"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-52fb76ef1d0so29622621cf.0
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 11:58:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790621895; cv=none;
        d=google.com; s=arc-20260327;
        b=ImBOv6KygwxqnmsnhrVeTVigWNGOPi2pi5EPH9q6m+3+vaoA+S0SduTJ3yU5NgUfSi
         gDjsezAbnfDN3Z5eRWTV56W26G1DESqTei5BCq32Frsgxzb13666VpkkMfRZnGgEO7zw
         9CdpS5HoCgBrE9oDWoDNDB8TFMBgvFRurj3QH1emyrlHzh36qR3c66AhaafEoG44PXS+
         bU40PLoOy+vbFnIR12Y8Qgm129YEvQO0pTkqLUR6NNIihT1EXTwdqs/2X7hNxqRKVqts
         D/yo2FtVHPKxlXvVkZzFDyRcfs0DXvCVgRlM4DBQj/MUMRzaYbzxkbdsy4K3LYD3zGQ/
         3URg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=EdVeXkgV9pi4EO1zLlRvey2I1xuy1Dyo+nGExdr17w8=;
        fh=wU034BwM6qe56sFmHfDx+UMFlWSdVW3fpRdddr3nmDs=;
        b=qrOssKHlardf6UtmXQGsDdbQVW7u1NO4/GCSfRj+6FWfDM3/bt5pHMwH7rGkR5NALK
         /jLjs/QHlRf3kG8q8LSai6bN7AAY+lP0ei7KtnhKNN+BUbM87ijQ0layxpE3RV9sk5+4
         z5aPmf69y32Q4zUthTrbTB5UiGb0C72vs9x+tIBfGt9wwnLfm/4jGhcAb8Qyokfbw9Y9
         mXodRzOiV9sPd7dAB5OtEdimm/Zg89jnlY3h7dKN+nAFrqyW9n6kD2qZmcZq6fHKGDrM
         DQ0o2Qv6i7GrpFI3DY8ahmjor8Cjd0gOIjyySsNQWccW7LOEStoJi4PtZhEoMKcFCode
         9WVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790621895; x=1791226695; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EdVeXkgV9pi4EO1zLlRvey2I1xuy1Dyo+nGExdr17w8=;
        b=DbY8/wlrg4bQLsWjDviYk0gWCmZ9poGvhlWMJthy1SfIzb8cx0yP5HfCGUajibNkOl
         ItOKJuSvmZKkp0tHL6+DVgwHKMRGOatNAqhbq5NdJNrz/5MK6wknMIvhT9f8Ty6OU8aN
         iCqSZ09deEa5Lq2bbJiw5MQ/XKRj6L3tzkvumJ6S78IRk1UN9a6ydFdHGtuIRWzD4h3D
         Wwm3JqaCCIZYGMKQgJ5ijb14dBrQiW7CH27yESn9rh0SstLrVVcWWQUa+j866aiJInu2
         AYvA6w6GowRAClgi7x6LZQ5UvuHYzHB7iQt5y6mj+k/CybvpDKy+QcsaKnxwxr5MjqNc
         raQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790621895; x=1791226695;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EdVeXkgV9pi4EO1zLlRvey2I1xuy1Dyo+nGExdr17w8=;
        b=ZOfjQws86J/HnvFG+zHX8n7Sfqh8dsyOBKbJiBZpW/ExCcxn1CRQsKuxWw2wVeXoyw
         vd/Opq58ns6XS/1Rv1gknOJIHE/D1oNHONLBzL7TAQTwZV5YUgt9svZwQaImrxpTr+kP
         DN0Szh7h7uLT52Cd9m4Uezz+I8oGjXzmyzP/aHmnIl4hMsKYcgZtVbRst6yrd1G0x0Cp
         3xpX1GY+Q4rMHxyTVOg3eSbUKUSGQR+SpV4nJb1f7dZbW1XoJcamPc8KbDC7IQxZNGhr
         IFWbx/uyh12+kjrQ8D6638+FyTWUpBI4l2Yh9SxFVWVbrsa0klz80bApXu0VZEPyIiSy
         ojQA==
X-Gm-Message-State: AFuF++kS4dgk0oBHTXL8nmFajRLwEajMBfR/wlqY/YXXYGuPTVVDa5cq
	cO6s0CC6wMVIu26VHfIJOGuQmR6xmlme1Z6EkI235kztQy/3Hsle/mSLCU815AK0CV4uq5na7bp
	dAS1foN9xRj39QmkYk7UY0xULilzwBAdVLlSbLPI=
X-Gm-Gg: AYBFou2pla1QCw0y8budjkobt0EcrHBwIJVg/ubZZ6IOgRFamqdxdmlnRGyWI/D2gZw
	Fs0OSqNZOC2bUpIoxi5ox04/qahlS3br/VpMcqsIOKZk4WLd4Y8GdusuOuDoy+N7SoEFiNBlYRz
	L8ToBHwqN2XzOBEa3U4/QaEOcA34K0j9YnjusCZzH3KHaB5Ko/99Tc9oP1IKjzJUfpKY1smmwC7
	kd3uAncsr/OLJwYBFs+n2BOJ0kbs5HQk74oNNboWI5qx9HeVbGBfpjlRM7aDPPt9CbV1mKabsp3
	2m4PXNpK4gjYPDlbwhlp8OhFhZKSK6P38I96l6wac6xAb60qSqVujfCQ
X-Received: by 2002:a05:622a:2615:b0:530:de5f:dba0 with SMTP id
 d75a77b69052e-5330b58b60bmr226374361cf.2.1790621895480; Mon, 28 Sep 2026
 11:58:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Gustavo Bastidas <gustavobastidas1010@gmail.com>
Date: Mon, 28 Sep 2026 14:57:55 -0500
X-Gm-Features: AclHuK8v69cAbN6Mxv7Gj90kU5NZ6vMy_Cubm_xuaiRD9dC9SDQGP4911uFgLWc
Message-ID: <CAPPWt=30acAVth+nR5kQ5JLuJ=LRTfmSBD2AjntNJgSvcVgkhQ@mail.gmail.com>
Subject: [BUG] VMD: NVMe controller reset fails with "can't derive routing for
 PCI INT A" / "no GSI" - Bug 221996
To: linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: bhelgaas@google.com, helgaas@kernel.org, kw@linux.com
Content-Type: text/plain; charset="UTF-8"

Hi,

I am writing to bring attention to Bugzilla #221996, which was
reported 15 days ago regarding a failure in the VMD / PCI routing for
NVMe on an HP Tiger Lake laptop.

Bugzilla Link: https://bugzilla.kernel.org/show_bug.cgi?id=221996

Summary of the issue:
The NVMe controller reset fails with "can't derive routing for PCI INT
A" / "no GSI", leading to the device being disabled after reset
failure (-19) and causing the filesystem to remount read-only.

System details:
- Laptop: HP Tiger Lake laptop
- Storage: Crucial P2 1TB SSD (CT1000P2SSD8, firmware P2CR033)
- Affected subsystem: PCI (VMD domain 10000:) / NVMe

The Bugzilla report includes all relevant attachments:
1. Complete boot dmesg logs showing the VMD GSI routing failures and
NVMe reset issue.
2. Full 'lspci -vvv' output showing PCI topology under Intel VMD.
3. 'nvme id-ctrl' capability data.

Please let me know if any additional logs or kernel parameter tests
(e.g. pci=...) are needed to debug this issue further.

Thanks,
Gustavo Bastidas

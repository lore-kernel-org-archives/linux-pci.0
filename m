Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A45340A6F
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590645; cv=none; b=ZDH0w3E3IE6s5iAWytYI4/ZNeSMim6+VeVph7t2cekuSaITI2lsuGOlLfssE8Uul37T5E9Mr7XiqpSnD67g0TU9yHS9XBMCEUDUsSnOxP2MRle2qiDB1/YQpnaqtaYLby25+9qTkmNLpsOhOOsxZy8YnOTNdZc2RkzgtymiDTbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590645; c=relaxed/simple;
	bh=UixtmfVi0O9e+lp1+ocbU49+hpHorKkUog0jJb/4yzs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=H8Ok0C/gM3CbvOKGiFJl7J0pXccZJcMopbDSA2AoHTno6UZ0v1QspvRCrcXfMKeFy2JjDqIQp2HZ6ZetnGDGIuR6UkuDXEDI/uKJ23FRQtXGaLPlFS6ucqlmz7oj0CtMj+WbjEbRnwmedHDvkU6pU8+Sl4HEN3m+QUpBoc/b5d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=Oe90JJxQ; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="Oe90JJxQ"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-66d14734b9fso171896d50.0
        for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 09:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1787590643; x=1788195443; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9kqUG4Y7OP/ZWP36l4r/TYvcdzgD970m1/NGdsYDVuI=;
        b=Oe90JJxQzcLZRjouoD4X6RAMAWPYO/EM0tJHRwtx2o2Ij1yRC7Ocu4kRjhoU5FrQYH
         6ry3JIPZnUbAsxHsRbsq97LSjYwUxqFcQLxcO1P6rIfZtDmaXz6X+qb5T+V0+KgoZ4Dk
         14NTpuVQCHLtYcjlaDVxhkp3kl5vZebl3c8pCBcC37UCGOAttwPpjp/9A8CYmXNQk1SM
         4k/UnTsdlQPKLokAGLo8kbs2yEp2131D54+wYSUR0KpHved8xWD0lI/UJJL4fG6TJjlz
         Sznyb74Cj3+uK5PY+sg0e10kJvNNPOta+8o+j81IzUX0ZC/BcRRmw23VD5yCnJX5KDxD
         Ausw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787590643; x=1788195443;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9kqUG4Y7OP/ZWP36l4r/TYvcdzgD970m1/NGdsYDVuI=;
        b=nprlJXMe78cxQdbw8oobbsaC40FGx3Btm25ppHYQ63MrVv7XP2MKxKk7QBxPcp6QaT
         wqqV9rOZJXHUkXvh6MjgPgoYkxxvwKn6lPevslU2GAO+Q4XiRHWuqmXdekyMLJTnK7FM
         zdfmqS0Ek9z68bEFfkV9MrS4asYSF2dBgqr62qzIZabQWB9Eny6Qam8QEVJ4iJ2iFGUR
         e4RunC0mGXZCopimAZUvypjwvDtuiALF9/QPi6aaHgM1FGEeL+Pc3xAJ4l96LwlBZZi5
         Hb6cV37rqHOythZu+mJn4rEvtMu+taDvTwpnfM8qks3TYyWH+Q8vVkLxh8CJUXo+UdMc
         KOgQ==
X-Gm-Message-State: AFuF++nSLQExn96l+RGg6RYG/M+2crGyl9E2ysKp2goMwBc9JoUSK/5R
	qprPL/Hxsi/SkRt18ApxclCCZaYIN9WuSBDflr6kHIo1VSOgqok9Eu7YGFbKfNGApIE=
X-Gm-Gg: AR+sD127S1byh4a8mSxqyOCDWXGd6rvzAyqOT2aeRxoyRWQisu3wC1j5bsQEM/s8dou
	WEcxJ5R1s4gTNqiP1DCUMZe0VRE0HV5vMFlB/01/Tf4emH/XHQaVabyBYjp1K4lNhHU8W8IKYay
	R3GYxyFXUVSvacQqHU1GcT2ZzkeZvXiEmWdF9jsWbOYwgoAbRG7tSdb/KfMWg/ZLt/7TYgtGVWS
	ybttx9gDCMnHJFnCwmw5QiWqIx2EJxsKvhyMZpsR+nr9jMffKLEyWuOKZrewFWu8t4c2gu90a5o
	yPc7xx4A7jLLEFm0DRNUKuyBuERuqaRC5tzCkhs9gM4i+8OPBWhxEQfiQDgiJW1kXe27Ypqjf5D
	XyJan4oZUuYRK84smLc+XfJg/H130r1n5n6FYAA65G80/EN0j/xQ6C3D+qXBGdm2j01oZM2+/rr
	/fxWZ8K1d31HIyI+NDloCLD7/kxKeG8qUQ9mpTS2+vMYKWJtk+EuIRta6bHEgeHB7uTOqmupz6d
	18ht83b6jsh5zo4GkYBUPZ+TF0Ptosl0vt1Px4=
X-Received: by 2002:a05:690e:488f:20b0:66b:32bb:740f with SMTP id 956f58d0204a3-66d144eaa59mr220120d50.0.1787590642820;
        Mon, 24 Aug 2026 09:57:22 -0700 (PDT)
Received: from [10.200.24.109] ([12.55.13.134])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66cf4665056sm4137612d50.8.2026.08.24.09.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 09:57:22 -0700 (PDT)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Subject: [PATCH 0/2] Add PCI quirk for Tenstorrent Blackhole to work on
 systems without enough host bridge aperture space
Date: Mon, 24 Aug 2026 11:57:05 -0500
Message-Id: <20260824-blackhole_quirk-v1-0-fc004672cdbd@oss.tenstorrent.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOF3jGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDCyMT3aScxOTsjPyc1PjC0syibN1EY0MjA0tjI+NEMyMloK6CotS0zAq
 widGxEH5xaVJWanIJyBil2loAMfl8TXMAAAA=
X-Change-ID: 20260824-blackhole_quirk-a31209323a62
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 joelsmith@tenstorrent.com, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
X-Mailer: b4 0.15.1

This series adds a PCI quirk to let Tenstorrent Blackhole cards to
function on systems that have smaller PCI host bridge windows by
dropping the 32GiB BAR4 that is unused by software. First patch adds
the Tenstorrent vendor ID to pci_ids.h and second patch adds the quirk.
The quirk checks if the host doesn't have any windows that are atleast
32GiB, and drops BAR4 if that's the case.

I realize that this patch doesn't account for every single case where
BAR 4 prevents Blackhole from being usable. Many of the reported cases
are ones where one Blackhole would work, but multiple won't. Examples
are cases on some x86 mining systems with limited BAR space/KVM guests
with limited PA bits that don't have BAR space for 8 blackholes. To do
this correctly, one would have to try allocating every other device
first, try Blackhole last, and drop BAR 4 if that fails. This doesn't
seem to be possible to my understanding.

I'm still submitting this patch cause it helps in many cases where even
a single Blackhole wouldn't work.

Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
Anirudh Srinivasan (2):
      PCI: Add Tenstorrent vendor ID to linux/pci_ids.h
      PCI: quirks: Drop unassignable 32 GiB BAR 4 on Tenstorrent Blackhole

 drivers/pci/quirks.c    | 32 ++++++++++++++++++++++++++++++++
 include/linux/pci_ids.h |  2 ++
 2 files changed, 34 insertions(+)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260824-blackhole_quirk-a31209323a62

Best regards,
--  
Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>


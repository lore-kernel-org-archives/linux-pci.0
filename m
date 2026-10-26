Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793037446;
	b=cYxGN5oulLLoLyezVgmb6QAYE3771V0aVvgKhS6jBzjlSfyXCH5fMjQO47oZgGDSBG3I
	 ikBm9jeUI0WcgPkITNZmkyBv12UtVhDTxY9gAaq+MAAFJ75l/61meR+NFvLhVv7XZcQuf
	 3d5GfHSIm+1LRQjkNQVwob+mpgRcxuLbutVac/m3JeXCwrrake7XnyIcbv80s1U4TU1wi
	 4DN9ZBTxf+cznbyLMvtUPlq+PFBkzG0eBOBaXpkWSzdOdQUbX9czLWDEHY955jzU4HO/r
	 FSQ10njQ2Sreof2mzEx8Qd1RDRunppVuVoiUfISG/9eEdYaIluObdrRVD7EHYGjJh9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793037446;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=FiuSLn7/IP2TjKEmv1diUaRQXZE9EbLamaDyI3mYf7M=;
	b=v105GwhdMXseUHh/x2lm+DHOwP9RLDetUebUYdb6f1jlEgd8rtDBhD3u/n3KIA1aXGpz
	 AiWiZGJyTqgCmNCs+mSL5YuVS7fEut+91nBstu7EbE5jghOlI585hMeVKqqK2nFMeoLXm
	 EPeYe01c2tEimwB/GUczc0fL10D/vVMBQridGoNSpdFmal6pbOErU/AnCQI9CJjCSWfVy
	 +sJZ6Bi9mr+ObRA6gilhxTkWfsHGxbF8honi9xy/SJqjyf078Rk0vYr+v5dxG/Xa2NaGp
	 4oEz44w0gs3mTCLIV/oYSTVXU7QZn34hTOZlSw7tYHqGnMnlzjS6ZevIa4Lh+9oTsFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=XISFKRUA;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF753606A31D
	for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 17:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF753606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=XISFKRUA
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3adcb81f487so5290587a91.3
        for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 10:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793037445; x=1793642245; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FiuSLn7/IP2TjKEmv1diUaRQXZE9EbLamaDyI3mYf7M=;
        b=XISFKRUAf1c+RoClOafojfY2G/derUG0ACrGzvBriTeE719kBcJOJqZrhOAqJ38PbL
         7fsyrNOQUP0akFAcs1K/wL4n+EIojO57I+U27uGBfnYUp51ODNPI8Vms62CtsNyUZ+PK
         gOQ09aWw8vqTrIBPvbKbdeDJ+PHrDqKBo0eMJXDtX48HDTwK5VxYVYpWqnfaLkFvg0v0
         DIUAMlhAPBUSpk764z6y/OZ2z07VJmRQojstEOPJwrQc+U8VRDHxlhrnXKIVV85ue9JW
         K8QPXEh4ZpqinlYkpuUv7vI3lFZj04RVmxPImjpts5Ck12YBBNFIXwf1xQFOLPlcqyda
         23TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793037445; x=1793642245;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FiuSLn7/IP2TjKEmv1diUaRQXZE9EbLamaDyI3mYf7M=;
        b=ifVoLiroI3syyIAkHFIL4TMmWazUBE5IExykFyP+ohcWfQ6Ob+J9z6xi21TJHhZlEp
         SaaXlg8ilcXug1d9KA8mYeT1fhpR1EYYSn+pdn5iLOV+u7XYT901wS2AYq6zL2Q9i/xt
         XRJIzgDsFxXELkVas43UfGHpKTpk4mPIwMFLle9P1p7FC9XY45XK/TM2peH3PRw/OehB
         /i2x6Vc9mfo37Ul0ap3PSBxovR4cloo6FrilXmrr+c9tP8+/KA7OCoNZY5PsSBwgsQKX
         B2dc34+xlw/OgDYj9iIWY1G0ep8EuUNlHURYCYFFCFe2f/In1WBulX/5yfRs9o0cOyzS
         fNJA==
X-Forwarded-Encrypted: i=1; AKwUvByfr32bOZExuvZ3s3oB0K9pIJW9XFXhbGTDy0eSGOGTOTO2hvqLgeWb/1l9hG7ko77/TRJ0fBMO8Es=@vger.kernel.org
X-Gm-Message-State: AFq9FYLVsz+GYkkZTcwunkEZk8BcJkp5ME7mGmQItTD8ljyheCP/P2+J
	mzz5UeEMjxvy6gpkOpdMM17bmGV8HmJBRsmZq4K6jXM9Bvl2ER1Rh68zjKCYQnWxxsa9vqbiE0Q
	p+Rxmt8BGqsTwSyrVi1NNen6ZAaBENtetJQ==
X-Received: from pjyd12.prod.google.com ([2002:a17:90a:dfcc:b0:3ab:2cb3:28b2])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:d605:b0:3ab:2236:6b3d with SMTP id 98e67ed59e1d1-3adead57d9cmr6211022a91.27.1793037445023;
 Mon, 26 Oct 2026 10:57:25 -0700 (PDT)
Date: Mon, 26 Oct 2026 17:57:24 +0000
In-Reply-To: <CAMAsx6dLGdqr+ZxG8FrwN-6r=5yVY8hk-c+7CVrAkS0zpKPmGg@mail.gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261012-fix-aer-mask-override-v1-0-49a0d7aeaea0@google.com>
 <20261012-fix-aer-mask-override-v1-2-49a0d7aeaea0@google.com> <CAMAsx6dLGdqr+ZxG8FrwN-6r=5yVY8hk-c+7CVrAkS0zpKPmGg@mail.gmail.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261026175724.1482083-1-rathodpriyank@google.com>
Subject: Re: [PATCH 2/2] Documentation: PCI: Document aer_inject's
 aer_mask_override parameter
From: Priyank Rathod <rathodpriyank@google.com>
To: Daniel Pereira <danielmaraboo@gmail.com>
Cc: bhelgaas@google.com, lukas@wunner.de, 
	sathyanarayanan.kuppuswamy@linux.intel.com, ilpo.jarvinen@linux.intel.com, 
	dave.jiang@intel.com, prarit@redhat.com, ying.huang@linux.alibaba.com, 
	terry.bowman@amd.com, corbet@lwn.net, jic23@kernel.org, 
	linux-doc@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Daniel,

Thank you for reviewing the series and verifying the documentation build
against the implementation!

On Sun, Oct 25, 2026 at 11:19:28AM -0300, Daniel Pereira wrote:
> There is one thing I could not reconcile, in case it is useful. The
> text gives Poisoned TLP Egress Blocked as an example of an error that
> is masked by default. In the sample session of the cover letter,
> PCI_ERR_UNCOR_MASK of the e1000e reads 02400000 before the test, which
> is PCI_ERR_UNC_INTN (0x00400000) plus PCI_ERR_UNC_TLPPRE (0x02000000),
> while PCI_ERR_UNC_POISON_BLK (0x04000000) is clear. The vendor register
> descriptions I found also list that bit with a reset value of 0. The
> Correctable side does match: 0000c000 has Corrected Internal and Header
> Log Overflow set. Internal errors match too, since
> pci_aer_unmask_internal_errors() is only used for CXL.
>
> Perhaps the example could name only errors whose default is confirmed,
> for instance Header Log Overflow and the Internal Errors, or cite the
> spec section if it does say that Poisoned TLP Egress Blocked is masked
> by default. I may well be missing something in the spec.

Per PCIe r7.0, sec 7.8.4.3, Table 7-149, "Uncorrectable Error Mask
Register (Offset 08h)", bit 26 (Poisoned TLP Egress Blocked Mask) has a
default value of 1b (RWS), alongside bit 22 (Uncorrectable Internal
Error Mask, default 1b).

The reason bit 26 reads 0b on the e1000e Endpoint in the cover letter
is Note 3 of Table 7-149: a non-VF Function only implements bit 26 when
Poisoned TLP Egress Blocking Supported is Set in the DPC Capability
Register (Offset 04h, bit 6; PCIe r7.0, sec 7.9.14.2, Table 7-280).
Per PCIe r7.0, sec 7.9.14, the DPC Extended Capability (001Dh) is only
applicable to Root Ports and Switch Downstream Ports, not to Endpoints
like e1000e (and in QEMU, pcie_aer_init() initializes PCI_ERR_UNCOR_MASK
to PCI_ERR_UNC_INTN | PCI_ERR_UNC_TLPPRE = 0x02400000). Per sec 7.8.4.3,
"Register fields for bits not implemented by the Function are hardwired
to 0b."

That said, your suggestion to use "Header Log Overflow or Internal
Errors" (PCIe r7.0, sec 7.8.4.6, Table 7-152, bits 14-15, and
sec 7.8.4.3, Table 7-149, bit 22) as the example is much clearer
because those bits apply to Endpoints as well and match the sample
output directly. If you or anyone else suggests the same, I will gladly
change it.

Thanks,
Priyank

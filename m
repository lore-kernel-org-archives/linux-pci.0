Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795585821;
	b=krsp6o1hDkeuSLA06/e/vNDeQJeVBqI7uiVKZUsC77HHTrR7d6jH9oZRb+0ZhUbAofj0
	 2mxtBHN1nbOXuk56TFsQgtrcoYfwEd1DMIahjaTEBbJiPFuzV2zojlj5Rkk/yzZQN+TuB
	 +Q5PIe3JpZZPk18q9NcYOUXbdlFslFew0wDRfX2eWDvmHePTKxULjXXKFewErb8tWMhNJ
	 w/G95whIAeoSQ/LHmkhGNgltTD7hJbvkrLyrzWhcPXaZZk7UzBlefIW5drJWsgeScPfSw
	 49yfbBbvxMpz6pzQecKSf04pWghRIgVqkl7bgx+rDgFOHVTDjyvps+MI2Z+52lCPk2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795585821;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-B4-Tracking:X-Change-Id:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=7TuopKGkuXxe9F8oaxjlU1CyosEDfE9sI6BY0c1BuLY=;
	b=mqhxS1b3Fie9vYMMq3L30AxgE1UQrtQSiCkXUSTYVgeVlbV0Q6/tBJRsrXf7TMBZl+nW
	 rOyDUWDCzX/B5cR3e8nr/2ROhd1asnkkMWT7O0o1o+A3nPY4iS6RLb42arBFwk7hARBww
	 6CDt18wWyD3vABnfs17Q1vi0Ebr3Gcm28V57TKwXjjs8pz6WnDsa8bai9dgHa4vcBKirl
	 2UQpqznDabqt9gpyUcYZlDc2mPYYAkjbEsHz1IWnXeuT1tdctAtSkHMJrVL9jErn7hFay
	 X5rIdzJsR9t7IFl1i5SrdT6/5bi6iFK99tKhzgRX//fpFzixQW4OLyvMA9hvJllXlXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cuW89rUp;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC63B606A31E
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 05:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC63B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cuW89rUp
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b41e8c1ac0so7855018a91.2
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 21:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795585820; x=1796190620; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7TuopKGkuXxe9F8oaxjlU1CyosEDfE9sI6BY0c1BuLY=;
        b=cuW89rUp/FqYJRm/IMeV89comPbS6z6Qk0gl3XG9nNwuD/NuWN/D4n1iVC5cJkXl+n
         PTLFpe1GTLmXaBv7OTnL8YYmE0MrhG25p6Iub04WRKi6CuqX9LSxy7JnDkIizZkavVig
         s5Y+WBceuSzfHfSY/GlstoStuG7TqGVUIW50fRV5iQU3hQJ60tHgN4nzE124qDYt8uCI
         Uw5ljvmoQf4uWRPfeE7fXUjININwaxlOk9PU6iRpXEPAxdN22YZ3o0B9T9r/3Y66riC0
         jz+1if7RB2Ozg8XlLOzM4/mMvblq8A4In47rffGrg8o3pTmePdKVJh5lLeuSIiCSho5p
         M+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795585820; x=1796190620;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7TuopKGkuXxe9F8oaxjlU1CyosEDfE9sI6BY0c1BuLY=;
        b=a4j48jA/4a/DyXPJPyXNpNQHqH1Eiqt48L+INcy5t+YadGdezl3dewunE7mXKSDggC
         eFuZ0FDzUTz8KZ5pcUjunMXXrMuj/clzjgaKbE++zBjfZnTdGm8SrEQkV6Lv1MEWwUXh
         vIQktSPJl2aMJ5KhIXlpOo6EhLzxykpcTtLmzmxTdR4wvc1sYQeW1IpmL6j0OGYONcxl
         EDKoEnrrgbL+NkgGQ2YeKik+u95zL+ivb9aT0Cmtyidkw+8a+DlJlgNFlqyNOMy6u0Ai
         euDS8P0Xr9nHOQT2vQN3hCdvYuvZ+nBeK47VQc9sqoWgaXGXJIxnzMcQ/91dM0jcTDM8
         oT9Q==
X-Forwarded-Encrypted: i=1; AL+hErHqN3pun7K9A8F2ZbcUivTsa/jd1IV7ovQkmgMj7/mwbXxS6VuRKLziq/MIYyLJkHdPtjB1WPFSYPI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+LNDwbfyVpx8kRqINHZnQB+B24gWvqMUDJmQfWSlOcDbjYWSqG
	+35NND1Gq7cg/0EZ4+W2P044B43BTkKnHQLM8sN44TDlSVHhQzDJeRtl14UEKTxzQb991sVoFgh
	2dR+U9kT3wLAk0oiEstYZfUZjtyDieM2xNQ==
X-Received: from plhi8.prod.google.com ([2002:a17:903:2ec8:b0:2f0:4052:30d0])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2fcd:b0:3b3:fa20:f83b with SMTP id 98e67ed59e1d1-3b41c954553mr17029147a91.40.1795585819921;
 Tue, 24 Nov 2026 21:50:19 -0800 (PST)
Date: Wed, 25 Nov 2026 05:50:18 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABp3BmsC/4WNTQ7CIBCFr9LM2jGADY2uvIfpAmGkE20xgyGah
 ruLvYB5q+/l/ayQSZgynLoVhApnTksDs+vAT26JhBwag1HGaqUN3viNjgRnl++YColwILTXIfT
 a+kMYPLTuU6gFt93L2Hji/Ery2W6K/rn/FotGhf3RqTA4alLnmFJ80N6nGcZa6xdxuHrzuwAAA A==
X-Change-Id: 20261012-fix-aer-mask-override-6b7d416c3d7c
X-Mailer: b4 0.14.3
Message-ID: <20261125-fix-aer-mask-override-v2-0-fb5931dc9462@google.com>
Subject: [PATCH v2 0/2] PCI/AER: Fix and document aer_inject's aer_mask_override
From: Priyank Rathod <rathodpriyank@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	"=?utf-8?q?Ilpo_J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Prarit Bhargava <prarit@redhat.com>, Huang Ying <ying.huang@linux.alibaba.com>, 
	Terry Bowman <terry.bowman@amd.com>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Priyank Rathod <rathodpriyank@google.com>, Daniel Pereira <danielmaraboo@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="utf-8"

aer_inject's aer_mask_override=1 module parameter is supposed to allow
injecting errors that the device masks in PCI_ERR_COR_MASK or
PCI_ERR_UNCOR_MASK, but the hardware masks are corrupted with "&= !"
and restored before the AER interrupt handler reads them.  Fix
aer_mask_override by emulating it in config space accesses instead of
writing the hardware Mask registers, and document it in the AER HOWTO.

Changes in v2:
- Shorten Patch 1/2 commit description and add a blank line after
  aer_inj_read() in aer_inj_read_config() (Bjorn Helgaas)
- Use Internal Errors instead of Poisoned TLP Egress Blocked in the
  Patch 2/2 documentation example (Daniel Pereira)
- Link to v1: https://lore.kernel.org/r/20261012-fix-aer-mask-override-v1-0-49a0d7aeaea0@google.com

Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
---
Priyank Rathod (2):
      PCI/AER: Make aer_mask_override effective for injected errors
      Documentation: PCI: Document aer_inject's aer_mask_override parameter

 Documentation/PCI/pcieaer-howto.rst | 23 ++++++++++++
 drivers/pci/pcie/aer_inject.c       | 74 +++++++++++++++++++++++++------------
 2 files changed, 74 insertions(+), 23 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20261012-fix-aer-mask-override-6b7d416c3d7c

Best regards,
-- 
Priyank Rathod <rathodpriyank@google.com>


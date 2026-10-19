Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792445488;
	b=OgGHVaSafSPGGRWw3WfRNHXBpJx+PHpRGt0ScOeQxNOZi/5zmVPTeh6vK3XdSRbqGR61
	 95xRaVfn1GG6aMqK5U+CY/f7TihMIGN8fZtUj0MdAOwFnK8TaI69kTXINUoJmXoy9Wt01
	 Wz7dYMto7tAtyHqzKkqKeFbWD1eyRI3FvUKFF3A0X4P8QAfZOjy5/Ec7bk/0O0LOKmji0
	 vRsTPUk54bHRyHGIvgu2LFPgngvs1p9USdI/Go4iVt/MUSNzTdMzUs7x+S8FxVQ8pMwwu
	 M/tqPl505f/LYHLSXcFSA5T5bov1rD1c1pJZe2ZZkvl5IJFYxIgthNFMHf/+ccR4gUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792445488;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=zjIHcsp6K5l9uxu4NW3RN2Ki168yByks7xW11UF++V8=;
	b=leNB4uyk2aLM+UDTLvZMbr2nAClYtdRaZ5Z8k63LDQ45YuIzTtnLirS9LNqKCfBUfxAV
	 KgbrpNEco9q6Ze/dGx5jinMfq6fwzWFee7bY+PMTyoN/dN5qCZmLdzah4emvLAPMWcxaf
	 aYxFBBPL48Jy/PJu0aZBb2JQSgbtxwaKrvuCmQnpvUrsMZL+GiHenWeIX3WiDBQ/NBLa5
	 vVckGwkGRYIEqr+KX8eKE8+RJ767rD7aywh7uWfLi1I4u9hWa2w66ywhUzmPwH+6i8E3F
	 MG3i2uVDFIn/otmVMZ3nQVEeSFRp1pCpcZUi9efRkK3yfFCx7trrKLZRYTgxQDhguhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=goOJaQw6;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3968D60A2618
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 21:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3968D60A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=goOJaQw6
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e9821ca96fso25588925ad.0
        for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 14:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792445487; x=1793050287; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zjIHcsp6K5l9uxu4NW3RN2Ki168yByks7xW11UF++V8=;
        b=goOJaQw6SkCjXEUB7sOfy2gnFYGrWDm1NJBssKP1r5Auu51286tZI/Kg5T9L858TOE
         YyKBB5SmGBVoiOzqS/tS6cRcZ05h4Xrb78AbopiQvDcy0wEootY1dRfZS8EqNzcOOE0e
         DXX8hXJBCvk6I2LowTEnVtjAKTWQA28LRMgl4ilU5EstyFjf52x9G1neQiUcKPE8lwT8
         KdnyzqeP+xJy/fzO/FCj1j2TEPdes9bTiVmX16S+Gb9M2/Mc4udYNfIF+iD1htq0Ywjr
         jX7vrNAeBDxHiwWfd8WKykGBTfcRUpOem60ZhjvC2LasnRbUMSS/2RQNsNIctRnfVp19
         fASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792445487; x=1793050287;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zjIHcsp6K5l9uxu4NW3RN2Ki168yByks7xW11UF++V8=;
        b=Jo3Nwsq3qy2XpvAwrv8PiywgukTriLm68BNTr+BlCA+eunMF8UAHkppnpllG9IGgz2
         7OxljgVNkBNSLgEKJD2y6S8sTFmX+PAo5jNUNNb6yySDhkBNULSGoGJ3ctm1TzxosBTz
         LNrNLTlDI6H1XMiFU0slQMPelN2W8G1Kdy1Y2FB8ri7vHZ6HRgjPyeth9SVRDrhob4Wx
         ZIMKvM+r8QmWpHAEeQdawmp4SLXNslxKIGZ90Vcpd8yNqbcy6gGomAz9xdRJYmq9KN8C
         90u2ddCk36zUFRpFvds2eN/TzBnPZQlzMSBqMofTacy4C/7IvF3wXivvkidzjygOlGfA
         k5AA==
X-Forwarded-Encrypted: i=1; AKwUvBxNMtLvWwapuXNMWCOlg+y0d9AeIbWQmYE7xlVIWS9U68OTRIFjOye+II/tSM38x99E4ZSKTZ3pmRE=@vger.kernel.org
X-Gm-Message-State: AFq9FYL0i5BOanIoMFMlLBidG/MiksYXWCbm5sFba9If88FzGppS9i88
	lJ6JXKNr7aSm63jkmn5T1loKcXiNsBz26/CTGiNKRb2nA96guhuhJlLPGOnbuiAKtY5Z6NrwPfp
	yNAo3sjja5qj1TA==
X-Received: from plbkf3.prod.google.com ([2002:a17:903:5c3:b0:2e5:b8db:503])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f711:b0:2e5:dbbb:6c7f with SMTP id d9443c01a7336-2e9a68356a1mr74031665ad.1.1792445487379;
 Mon, 19 Oct 2026 14:31:27 -0700 (PDT)
Date: Mon, 19 Oct 2026 21:30:51 +0000
In-Reply-To: <20261019213054.3157159-1-dmatlack@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261019213054.3157159-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261019213054.3157159-8-dmatlack@google.com>
Subject: [PATCH 07/10] PCI: liveupdate: Never assign resources of incoming devices
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	David Matlack <dmatlack@google.com>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Logan Gunthorpe <logang@deltatee.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Prevent the PCI core from sizing or assigning the resources of incoming
preserved devices by adding a check for pci_liveupdate_is_incoming() to
pdev_resource_assignable(). It is consulted for every resource when
sizing bridge windows, in pbus_size_io() and pbus_size_mem(), and when
building the list of resources to assign, in pdev_sort_resources().

The resources of incoming devices are claimed as programmed by the
previous kernel while scanning, and claimed resources are never sized
or reassigned. However, an incoming device may also have resources that
the previous kernel never assigned an address, e.g. a disabled ROM BAR,
which therefore cannot be claimed. Assigning one of those would write
to the device's BARs, and updating a 64-bit BAR temporarily disables
memory decoding (see pci_std_update_resource()), which would disrupt
memory transactions targeting the device's other BARs, such as P2PDMA,
or MMIO from VMs whose vCPUs keep running during kexec. Leave them
unassigned while the device is incoming instead.

Assisted-by: LLM
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/setup-bus.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 4bec76950f46..b82440394ee2 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -311,6 +311,10 @@ static bool pdev_resource_assignable(struct pci_dev *dev, struct resource *res)
 	if (pci_resource_is_bridge_win(idx) && res->flags & IORESOURCE_DISABLED)
 		return false;
 
+	/* Devices preserved across Live Update keep their resources */
+	if (pci_liveupdate_is_incoming(dev))
+		return false;
+
 	return true;
 }
 
-- 
2.56.0.212.g129ede20d9-goog


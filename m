Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794389453;
	b=YXVyNaZt8fos2/OLvw7DR1X7O5AviZiNG3Xzq/EGiZg9H+xRziFrvYbjWfutIR4ggXt0
	 L7yL8sNIYplw3eXaVmp5ObcCyR+QpoGHcQOOchFarqgcQj7UKCIePR4pOgxpWqqPrIvzP
	 YFdNDHDMT7qFHs7yxBOfELq5z3zGB5PbPO/yJFK/FToOt9KeWqMG+Y7PSPgJYE159OP2Q
	 ywuL2bJd+SBm2wYA7YJwuYW8bwsePluaYuk3D5TBjjH+oMcUX9oiWeyEc2roK4rv6qHR3
	 ArJJsZOkRSj7m7URM4x75adqXD1RLZExSu36YLj21DJYVQuxym17axj2DfzBUQtFK8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794389453;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ohdbjek4hr8Jhs6bONF/iNmbouRA5J+FWduvFT7IpeM=;
	b=EIeb8QZnVqI//UCeBr/aTjQouYckVrjay+cd1WLWh+hmZlHYDPVs1S1ng6DCV/SHOnQH
	 LZCM8Zx5KkQrfCbDV+uiL3EcblIt0OOMAdDSoPxuN1S8cWL7+Lpfxxjw5+TLx08ar8TPZ
	 3uqsh3zbL4/7rAAWkqGVUeCzxYk+zRy7dWuWxUKyl5HPtRhl8xBlMOzgjCszydtZqAhLr
	 gAcaGB7WrRrLwSqdFjm1mWK15RKhH39c8y4blJ4c920YqVL7R+oK0yll8diQUZwnz5UYT
	 kXnuSpC2pF1XJ+JobCJ7oA8CAY+V07g4C8miDg75l1diVY8qqoeEpwXOF1fUKBPjrMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fqrgW2iX;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9B760A2616
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 09:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D9B760A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fqrgW2iX
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so25620265e9.0
        for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 01:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794389452; x=1794994252; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ohdbjek4hr8Jhs6bONF/iNmbouRA5J+FWduvFT7IpeM=;
        b=fqrgW2iXgHIJeJhQma2d8o1vZNeBqNbbG52ROBSXr7B/rKI6naTwS/dn5wgSlDXWyY
         v/ZQuKpMBHa7ZQxHt7ZeAfqIImafnW85f4Rc39C8m/lCZsstB3xUd9BbWtoX2dIHhB+g
         BhO5+RX9d2HCuar+UqD9j8ByYscf5nN5vEkO0VGjb1KLKc6Iex/tpGh8j3AnF6xfhNjN
         ZNLVuPm5/XyQ2CIY0HBr8vPI7Z14LXZFNOk5NpAFsJOgD7EPc20Ox7Z/9IFWcTUev6Hr
         Exm7B0B5OWTFlFbwj7M3W0PHhe6AQrmFle3vOCwPN2DPjV1WpA0n7PXQk5kZEC0jnC3t
         t0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794389452; x=1794994252;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ohdbjek4hr8Jhs6bONF/iNmbouRA5J+FWduvFT7IpeM=;
        b=pbhbUhBSZqqV3PPxxx5j2lPA1GnohGSteJY7T/i9wjE4TUGOGwRuRGeBEpYoiExfDz
         1v7Z7Y312hS873OfZDJ8wlmq4U1U5yvPazQuKml1Snwv4C5XcXBF6x4Y2odnyn6hfTi1
         onfg73Gc46AASfESM80VSSuDDmyaTc37boWFNAji15rVVuHiZD6fsoA46/fQL7SxZgXM
         kA9T9fXE2wMGAHzCnJreXVgeAcVQi3+iR0ZNlzp8qhBBah+Z76M682le05pIZEkxwGXs
         uj+iy4rCysLbMtZn8vpmc++k2Ir0lKAfbc7cK0jEuPhTAvpD+QXBqwNK7bXGw4IY6StP
         KHsA==
X-Forwarded-Encrypted: i=1; AL+hErHQR42kEsG8udDv+BAtfI7f85IWnhPfZX1v5aOcLp4hFsypaTMWg9CoSohMApY5m9UCi4GPT1+6Z+Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z+SDv/YcglWqYuj07DLMlhKy/Ey6Ej6lLGAuOghRJrsww2oGgvq
	W7zjyhbX0o8ENnbmeyNUajcpdJ0uCO8y7szL6B7qWquJmtOTROMoxOV6
X-Gm-Gg: AYBFou3LLt37oG6X6zfW92eEThAI34FGTvZVhReQga0HRNM7uz65tbGBVKJ18fjJwju
	8llH3AQvB6CZKrZ1wlOrdVHWrwGprRjbeOUvTLMLPMbR6WKbUHZFlKle0Rgbn2KfscCj4xkFL4v
	On56SsXqZGUEH3HCaRRtVBBHPnUyGDFp/mv4L+7UtDM5VVPaIE2yrKpy18HXjafxQIRZNiMpyvw
	zzY2HcKi1vg2WJ66s+YmoJeavn6FakvpbVHopoOnhIs6CXc5EAbqiSQEe1SjiwN8tXkUv7UD9d1
	qrlOjFUtbZSDpGmuWQULJn0VGNDKNY5sh5uSBRA3kniwrkE5KviQNUIpkpSa+kp9EEthQ1eUWXQ
	09RuKE27aa+j4UY8u13QsUtPQx4DJ4MqS+RhthsSA+pdvRV8HuBJIBgzQ1892Tz6JzSHLTGhA8p
	q7nbhVfu0Z697a356Jf6XGr+hNkfUDwzWjaKlINUI3XgRTCdhQVzPrkSuzFOFO9EwJscI2BG1IN
	+sw3O6MTzWpxW65SuYidI6q7x+oTum3hP1DAa8BH53hWBye1JEdqSzJXzif87y0rSa/j1Q6/Stw
	RJqOBJeZW2t9skR39wTaYqE3lrQIx0Qwpp0n6eXrciPdQkILETvcUidj2wRR1WBghnvPq2L3geM
	Mo7+TzSW4kFR3K8iYA6IDNvGKYYem3eA6ViOVn8DCNvRZQu/AiGi03xGrRPPhD2crlkDxd2tmD5
	V97fKXGFBG0T8=
X-Received: by 2002:a05:6000:220e:b0:48d:ff0b:9b52 with SMTP id ffacd0b85a97d-499c72712d2mr3050951f8f.19.1794389451603;
        Wed, 11 Nov 2026 01:30:51 -0800 (PST)
Received: from AHERLNXVDANI01.lgs-net.com ([193.8.40.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498362eb14asm9175839f8f.34.2026.11.11.01.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 01:30:51 -0800 (PST)
From: =?UTF-8?q?Daniel=20Via=C3=B1o?= <danividanivi@gmail.com>
To: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Cc: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	dima.ruinskiy@intel.com,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Daniel=20Via=C3=B1o?= <danividanivi@gmail.com>
Subject: [PATCH iwl-net v2 2/2] igc: treat I226-LMvP as an I226 device
Date: Wed, 11 Nov 2026 10:30:35 +0100
Message-ID: <20261111093035.513635-3-danividanivi@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111093035.513635-1-danividanivi@gmail.com>
References: <20261111093035.513635-1-danividanivi@gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The I226-LMvP device ID (0x5503) was added by commit 8f20571db527
("igc: Add new device ID"), but when commit b8897dc54e3b ("igc: remove
I226 Qbv BaseTime restriction") introduced igc_is_device_id_i226(), it
was left out. As a result I226-LMvP is currently treated as neither an
I225 nor an I226 part.

Add IGC_DEV_ID_I226_LMVP to igc_is_device_id_i226(). This changes the
behaviour for I226-LMvP in the following places, all of which now
match the other I226 parts:

 - igc_probe() and igc_io_slot_reset() disable ASPM L1.2, as done for
   I226 since commit 0325143b59c6 ("igc: disable L1.2 PCI-E link
   substate to avoid performance issue").
 - igc_tsn_enable_offload() and igc_tsn_disable_offload() set and
   restore the I226-specific RETX (Qbv full) thresholds.
 - igc_tsn_enable_offload() handles the FutScdDis bit and the base
   time as on I226.

Intel confirmed that the I226 TSN functionality introduced by commit
b8897dc54e3b also applies to I226-LMvP.

Fixes: b8897dc54e3b ("igc: remove I226 Qbv BaseTime restriction")
Link: https://lore.kernel.org/all/5d45a583-198c-467d-afbe-8f19398e82f3@intel.com/
Signed-off-by: Daniel Viaño <danividanivi@gmail.com>
---
 drivers/net/ethernet/intel/igc/igc_base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_base.c b/drivers/net/ethernet/intel/igc/igc_base.c
index ab9120a31..6865fef40 100644
--- a/drivers/net/ethernet/intel/igc/igc_base.c
+++ b/drivers/net/ethernet/intel/igc/igc_base.c
@@ -447,6 +447,7 @@ bool igc_is_device_id_i226(struct igc_hw *hw)
 	case IGC_DEV_ID_I226_V:
 	case IGC_DEV_ID_I226_K:
 	case IGC_DEV_ID_I226_IT:
+	case IGC_DEV_ID_I226_LMVP:
 		return true;
 	default:
 		return false;
-- 
2.53.0


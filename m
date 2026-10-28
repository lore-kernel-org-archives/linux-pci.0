Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793208640;
	b=aL8Uj1KP9TUWHWldKsqEIech/6KlShdTFn9FoqUf8D49I3ayNeSmkolY+YdhjnWGD3+v
	 hm4u8wK3L0C48iKeHSCC8/SJDTZayrxSbFOrC287vCuBuMAMEFzA9hVpdKHms/qVvXxrr
	 m61BIPL7CAx3JSkAn8k64VnOxxGwokwoU/y+1VwIT7Ep4kZwkpUxDi48BwAQbIupCL1BM
	 OGqORxSBiQCKX+fbS6g+BmvNt9ZRuMtXKMUQ8i6mzhpYHaqESvCDTJfx1LRaPxPmpVWcP
	 359geTHtybmsn+K0tQ5dycC54EDdmVqx8XkGG7DGqRfRVNbqsNFvp2LGRYiVED1ziag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793208640;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=aT/pVU6IgIaYwku4adsSNoBoyYJO/ByS0tjhWNwyOaU=;
	b=FWC2U60UE49PceUFVECO2YUZMSb61IB/RVy+wb81Ed9f78FnqhBW8N/C9xVfgZeE4WLw
	 gswbHojWVABOjSPqjSdFuk44koX1oNf00WB2+Yqx/iynp1Idw2t/1v6PTMZcZveVYuh2x
	 eJJmVYyGlTaG+tzWPORFXwsKPcft7F+Fe1ZfRS0BX4BwlhRh9hQiJQp9JwfhxE52Kl2gk
	 bkTbMy6Syy3R21U6e0RGlv2plMqXy84SIOvPk2Ch5bZ+bg9DFCYXaDGpOq8FyLvCXpkw1
	 LvepEOstfNd0a/dDe0iFW+Zhav+0x4ToQOh7sukh46nz7v7NLtXWXvGpqvWrjzqLQvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="i8oSMlu/";
	arc=none smtp.remote-ip=209.85.210.198
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEE1606A31E
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 17:30:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEEE1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=i8oSMlu/
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8a065d0e9deso1042077b3a.0
        for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 10:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793208639; x=1793813439; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aT/pVU6IgIaYwku4adsSNoBoyYJO/ByS0tjhWNwyOaU=;
        b=i8oSMlu/WkbIYGthAShj23qls5PPa/cxrQ80XRTY7eJl6stpBqjqTJoVWruuxGySrD
         Zet9b9zdF8MYfRamF8DMgs5eTpbkL70dL230V2a5giSqkRbElhM3zmNCyl4TDOU21mF3
         I3RNxSFADpGlcEccnqECxbVl5H2SzwAJeGg4F424R0B03qLvEhXDR1Tb1gRgpRx2Iuc/
         CUw3ZMIVtBZO67OfWZ5JBfhx6S+/MgGHU3Bb5FrcpxKbCCCeWZaNkCWf+3RcGagxU3zQ
         V4DU3aAnNuK+8QFF6wVKtsVW16pHwRNHSQD0WqALj+8lM+nCIiN80jMQl1OaLNpyOFrH
         QWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793208639; x=1793813439;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aT/pVU6IgIaYwku4adsSNoBoyYJO/ByS0tjhWNwyOaU=;
        b=CfRwF0s7N7CQ+JVG69BoctfGZVvDXR8P+aVZNAgVpGRwru2JOKiyD3n8ja5ADc/nlM
         zo3a+pT/+aYCww0SarfyJBQojX8vWNhOAfZktSWdgwt0oAPbYHz4Rl7Aiksx8wo5kRr1
         GfCBs6PyTVDMZw5C1f3LnsUg41YXhcUEnk+R9jVMO8tQbzpOXhetNEwEkYXeVz1sy+ya
         VcI4VlW88qVFgaknRcaPImRIJ8a3nszSgY2+8WIsh7rwM3WkpNX/IRFtqZuOx2rmQR7W
         s8w+SI07mbk+JdX7q+cIVzs8yDlXBI/O3d7ftZNSMhUEwzg98B+B8zk6xtQwPeHocKRX
         GSLw==
X-Forwarded-Encrypted: i=1; AKwUvBzxVbYk/ldTUuvvdGpSN0vajPTdrjfbwIBvw4qmhuAr0LvgTyn4z5KRKTfzmVMiExS6+nJF5VFTulk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLxsqOVSe75wWCui7PMS614kPXGDFJWjDLrGovVZt5pH/GmmqSK
	m9fiz772WuaQeXugzCj+LOYzZ5TWZxnM4Cm29bBTyVahb3P0+0ndyVcNsnc+vDlmzYBi07xtybw
	97LXiLovJXAtNN7AA/mUUuJnPSo3z9GVzVw==
X-Received: from pfaq14.prod.google.com ([2002:a05:6a00:a88e:b0:89b:34dc:b094])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2e93:b0:883:7868:94d7 with SMTP id d2e1a72fcca58-8a82efe49c7mr111145b3a.10.1793208638703;
 Wed, 28 Oct 2026 10:30:38 -0700 (PDT)
Date: Wed, 28 Oct 2026 17:30:38 +0000
In-Reply-To: <20261027230853.GA519764@bhelgaas>
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
 <20261012-fix-aer-mask-override-v1-1-49a0d7aeaea0@google.com> <20261027230853.GA519764@bhelgaas>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261028173038.292999-1-rathodpriyank@google.com>
Subject: Re: [PATCH 1/2] PCI/AER: Make aer_mask_override effective for
 injected errors
From: Priyank Rathod <rathodpriyank@google.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, lukas@wunner.de, 
	sathyanarayanan.kuppuswamy@linux.intel.com, ilpo.jarvinen@linux.intel.com, 
	dave.jiang@intel.com, prarit@redhat.com, ying.huang@linux.alibaba.com, 
	terry.bowman@amd.com, corbet@lwn.net, jic23@kernel.org, 
	danielmaraboo@gmail.com, linux-doc@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Bjorn,

Thank you for reviewing the patch!

On Tue, Oct 27, 2026 at 06:08:53PM -0500, Bjorn Helgaas wrote:
> Can you start with a one- or two-sentence description of what's going
> on here?  Evidently injecting some errors doesn't work as expected
> today?  As long as the justification is compelling and the code is
> readable, I don't think we need quite as much detail about every
> little implementation detail.

Good point, thank you.  Would a shorter commit log like the following
look better to you?

  aer_mask_override=1 is supposed to allow injecting masked errors, but
  aer_inject() corrupts the hardware Mask registers with "&= !" and
  restores them before irq_inject_interrupt(), so aer_isr() still drops
  the error as masked.  Emulate aer_mask_override in config space reads
  and writes instead of modifying the hardware Mask registers, and
  document the parameter with MODULE_PARM_DESC().

I am happy to send a v2 with this updated commit message, unless you
prefer to adjust it directly when applying.

Thanks,
Priyank

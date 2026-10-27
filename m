Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793111701;
	b=oMl01s/9/CaWL14NvEEjLfPawn6P/sudtmuBJI6zpPBTtjMrUe7oYvoT14bNhrynYKy4
	 z+UV9GktBFK3WTOxyAw4EzHv59XghQ65lL+0Lyqaai9EvJp5MDNuX8glp9mu44TPSJjvM
	 yf70YUbwHE+1syAXH3N9Jo4r29191da1b11XjS2MVjgD4BhG9mKIiu6NVLlrrGBM2zXH+
	 21iFJ+XuRJobJOCzgAQwnDv3Vt9QjhhkbEnrlMkJTnNtUtH9J0Mjt2grEqsz2/JeuEASb
	 xmbff3aqPGvdjJxgFkDKi4D+NMR3MmK7Vuxa+mi+IbQ1z2yTEFCBf5bPBbbUA8nVe8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111701;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=kpMVzTEsyq+10ygaZmcWH4opP1T6BP5uZJEA0uY70vE=;
	b=ammpm6+UioBasrzcnsVyDw6R0ebDUrqolVhVPNDFqfNpm6EGB9kljT4sl4t9xyLqItsT
	 ZGecUjLv5dtBsQYY6LIjjrJHcSI/dh4sOXJXyGInLIxguDLywFB8TLdvcHOjC8Pak9P6D
	 b4DKmK4w9uoLMUaNEgM4cC7M5P7HEaeW1Km5cjC47xlm7UiZpRTIIsnTMLERdBrk+9RJJ
	 MkYlkzeQxGd5KH60TB8WvmcupkFzn5h0cVRFOtla6zptuelNcOrhnZLWX1SBv/99IJ/Ek
	 6DTa5A6JZo/jaVLg/uqFTywvNs8lFylDWV4qS2jVVOVYHK0Qrh0UR6+/9s7FlLFoxdA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gNL1x+Xv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BA0606A31D
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 14:34:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41BA0606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gNL1x+Xv
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-53397554beaso49865311cf.3
        for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 07:34:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793111695; cv=none;
        d=google.com; s=arc-20260327;
        b=babDgO36UL2X4YDcNux4YGf7Z8MUEAfSYG5NCkwaoe/SUTmjXcuvGgl0L6If2WwRAL
         w+DCY3MdhGmUTQSFpZSt+HP7vYEpPYhYG9LssyMkd+957iUdeI/Eiwf+qXzfGY5ugpms
         /bJPYS9H5yEBrpy7hlHqBaKTUc63oRAnXRIqGHzNvtLzdbNHlGf97KO9a6RmgaxL8LuK
         4C6ghy3yyQP2obMLXFtJ7LVXHG9JgOkCX0LN8uP90COaywCDr9j/1nuSKoSvaBPRB9EJ
         CCTDxJHZZ7ug68PQh+8Rmyn1X6p4wiA175C9n5ETZALevC1anTWOsJPMSFf6znS0pO0i
         Q1vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kpMVzTEsyq+10ygaZmcWH4opP1T6BP5uZJEA0uY70vE=;
        fh=NSGw9K9nvFTr0tVrCDZMKCS1z0KgSeZHTVEWOjo1Unc=;
        b=FUOgXHo407XZkRsdVS2MoFd9zyG/RE5dBHL+I8goe6QqorRwp4eRsWc9aS+TcRf2KB
         Hhs1O37Z7PVD2yDEsaJte/j69L0JrpDAIN5FU5uSBPRg6ASAwfEOM59g0r3V+8G55/Fq
         yclDOEqwbDa8+D66cTjUQcISMyPvmyJm59lKwM0YoLQpmPNbdaqN50jfl14W8dYTGg9/
         tPEfc5Wf0mxvDLaufNpJSlQQvbBoV3/8ag7v+Kj1ews1dNQgzjDi81UCYlME1hWIvVWK
         LOgCrfmeKIy5DwweQHRiZq0N3buzdeNXb4DIa8uodcmnMePEei2+2slRUafD9waBydZd
         CC0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793111695; x=1793716495; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kpMVzTEsyq+10ygaZmcWH4opP1T6BP5uZJEA0uY70vE=;
        b=gNL1x+Xv1DnXFPpzgePiAQuuZuxGQYp4vZ1KZEbsXr6VBegt4pJtXNzLeNxrCpoSCI
         vyOi7v6/0+IApmMQXYD6AGe5EUrYKJPHhrDm8nm3kiAEl/doeYsPq0sQTlTGWyGIHSax
         8uUnTg6CWkRGKsQ5Qzhc3YiWHw/HIdwgW7WIjIl/n587BwpsChYbbMrR1t33toZDX5pu
         cO31gnJ7HsIsGJijHvaWYd7DrEnivbFfmTpnn+VmfvsLebMcgPHXqdxCtjs4hOFv+opL
         /7mt9QweVw3fEG1JnW37At3rsmCLkOf1b6RdlUc9/i//g2ff+EPN3LK9o7hPShF19pzU
         QRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793111695; x=1793716495;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kpMVzTEsyq+10ygaZmcWH4opP1T6BP5uZJEA0uY70vE=;
        b=Y7R9frdl505RwMLcqltvfQkO3x9UbdgtwwjrwkhKX9dZX9jzKHr9wL7aB7Q+QFhxhh
         0m5sQycoQhLAT+CtS2aGzzd/3rxl3ZwiByR0I9k55g0AjO4Fdyf7i75RS5aQboZXqCgc
         Wbee0tYsYBMvNciqADWmC/oMsBTk5MXGCcbSicDWuIkCZSthYwsKAbok3yUvpYZjifHD
         lUgZ9yjAiM96+81GjJzdCinSzeEw/zUXWkpw49WLFKfyTIqDwZuWPDjhqdpzQgK1ss7+
         zLt+2/SEOyedYYbE90rsmfEVqvw3wPPmQlxKLHmg+xz9lQYZmAOFDbijRLwBtOBK3LZM
         1K6Q==
X-Forwarded-Encrypted: i=1; AKwUvBxg6oaE8RrutGsMIn8uaCiDuZsR+EpOkPWA9XAMDXfqIukplvkB/YgKO1m/nrLJxoWUWbPDvGRjXQg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKc+NtQjIRPAc5bH9MeBlyf6LWwTo+pJxsfj4HZF3xO/eN7V7/x
	wZf5P15k8GE2J+VlFQ4qQjR0V+SWOVF1HBWB4+OVSmXaxqRks+yUu0t2btkrOtbSSARsdeHsue4
	+NEE6HjJBVtLBdrkd6eIaDc0b0FoGyE8=
X-Gm-Gg: AYBFou1VMI4CpMoeyFPJcFB6caHDdzVWbKnu6msw0aKZFBFmj0oVuLw/4snOS7wmeae
	zdDzbgCIF7+xw5rxB+jkCuZQESvHlg4xT1rIQtHPeGPpd9CBn58p+/P4A5O4IcdSX4IMjjkDZ7e
	5NuWV7Ir0ePbb8l+wJ0kymXyobkGPnn8xBH8M+WuFchQol1Qbjhe8N6E+2DMol+6bT+57RQF/p0
	ykF9XZ4Ro2ZSl+9xZpFDD1THSux/S1SyWsfZmweXekeMOQVGxuz15xUl5XflJT0Kj2InaRsj7Pc
	ORIEKZNbZsmbl/v+b26LiUqgBo0GvomkgGJOhUcSJo+mBQxO4A9k09hUS+EwMZRws+owpClFiMI
	hSygc4Wvp5u82gkyySHw7TaOVv0yNnip6MnXAlXTSfSt7u6leBlmkFm6hG+38jpHoQdHPAi3w0w
	Lw+AH+GLK8kZecryyw4UGcjxhQVrNo/Nb6V0Z+mM7/Os/kGgAj
X-Received: by 2002:a05:622a:90b:b0:536:6bc5:2fb9 with SMTP id
 d75a77b69052e-5383b4a928amr176076021cf.14.1793111694872; Tue, 27 Oct 2026
 07:34:54 -0700 (PDT)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261012-fix-aer-mask-override-v1-0-49a0d7aeaea0@google.com>
 <20261012-fix-aer-mask-override-v1-2-49a0d7aeaea0@google.com>
 <CAMAsx6dLGdqr+ZxG8FrwN-6r=5yVY8hk-c+7CVrAkS0zpKPmGg@mail.gmail.com> <20261026175724.1482083-1-rathodpriyank@google.com>
In-Reply-To: <20261026175724.1482083-1-rathodpriyank@google.com>
From: Daniel Pereira <danielmaraboo@gmail.com>
Date: Tue, 27 Oct 2026 11:34:43 -0300
X-Gm-Features: AclHuK_njZlT_A6caNrXNbbG7gBGxHmrzYc6IWZzccr4qUxgXvxpemc8dDRNGgY
Message-ID: <CAMAsx6fdOmV4DH4WCi6u_EadZxdEg10FFnAKSe=g7duTW+eDdg@mail.gmail.com>
Subject: Re: [PATCH 2/2] Documentation: PCI: Document aer_inject's
 aer_mask_override parameter
To: rathodpriyank@google.com
Cc: bhelgaas@google.com, lukas@wunner.de, 
	sathyanarayanan.kuppuswamy@linux.intel.com, ilpo.jarvinen@linux.intel.com, 
	dave.jiang@intel.com, prarit@redhat.com, ying.huang@linux.alibaba.com, 
	terry.bowman@amd.com, corbet@lwn.net, jic23@kernel.org, 
	linux-doc@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Oct 26, 2026, Priyank Rathod wrote:
> The reason bit 26 reads 0b on the e1000e Endpoint in the cover letter
> is Note 3 of Table 7-149: a non-VF Function only implements bit 26 when
> Poisoned TLP Egress Blocking Supported is Set in the DPC Capability
> Register (Offset 04h, bit 6; PCIe r7.0, sec 7.9.14.2, Table 7-280).
> Per PCIe r7.0, sec 7.9.14, the DPC Extended Capability (001Dh) is only
> applicable to Root Ports and Switch Downstream Ports, not to Endpoints
> like e1000e (and in QEMU, pcie_aer_init() initializes PCI_ERR_UNCOR_MASK
> to PCI_ERR_UNC_INTN | PCI_ERR_UNC_TLPPRE = 0x02400000).

Hi Priyank,

Thank you for the detailed explanation, and for pointing me to Note 3 of
Table 7-149. That clears up why PCI_ERR_UNCOR_MASK reads 02400000 on the
e1000e in the sample session of the cover letter: bit 26 is only
implemented when the DPC capability reports Poisoned TLP Egress Blocking
support, which does not apply to an Endpoint.

> That said, your suggestion to use "Header Log Overflow or Internal
> Errors" (PCIe r7.0, sec 7.8.4.6, Table 7-152, bits 14-15, and
> sec 7.8.4.3, Table 7-149, bit 22) as the example is much clearer
> because those bits apply to Endpoints as well and match the sample
> output directly. If you or anyone else suggests the same, I will gladly
> change it.

Yes, I would suggest using those two in the example, since they are
masked by default on Endpoints too and match the sample output directly.
This is only a suggestion, of course; how to proceed is up to you and the
maintainers :)

Thanks,
Daniel

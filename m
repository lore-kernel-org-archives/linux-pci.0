Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466343DB980
	for <linux-pci@vger.kernel.org>; Tue,  6 Oct 2026 18:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791312166; cv=pass; b=BOM7V7TCc5lTpSGuXLFWmqFDm7R/I/s73GjWcoAmiC3rCSKIlfcKODtq21Mk4HXq+jp6K/67sgaC7B0lG7GRimtPdCh1wkAisI1u1ANhJk59H2YwROm6mDDFCN+2Zn/Wl9sLhjd6frd1rClwZ2Wc9YleNansy2DYvEFFtXaeE9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791312166; c=relaxed/simple;
	bh=pAxVZXVgniokbrQYjLKLxT5TWxVz1UJKdaaB1MVQK6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dgCqMBcNVNgyPsj8SJ0kB9jcCTykpaDtwDVXs1jfHb+3kRix+b6rIwYZleMd6hjI9dZy3R2Z3BJKnvydrAs06/ZaSk/1rdVogx18zck5Ga0907in0DGrl7r/eYXEvOjzpAs3BcZZKTEy4f6zAuZXPM7NCzQQGOekt/J4JXsDZL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XP2KY62N; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XP2KY62N"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2db33db4de9so9395ad.0
        for <linux-pci@vger.kernel.org>; Tue, 06 Oct 2026 11:42:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791312161; cv=none;
        d=google.com; s=arc-20260327;
        b=RnVpxuTW5g7DBg5PIOkNS70aDZQgJE+8+0KZ+/1acYxsMa9IX5eR7HRkNSVcbv0Tw4
         rPsONVMOHL9oTr7oEkmDZgQHbMvuUD+KYYE5qTjHXMOpztH8LyOGTdDLFDgbERJoTPG2
         e62thdbDHSwYXavxzoJtWU2U6jOAwnmEPWaO2Bg9ldg/h0MLNiAmu5KQI4u3XWwdY0wo
         y61X9mLYfqF/H5E3YZ32NuiZKEPNFYMHiPh72TpOiONpo4O3bDbjUjJpopzDFsJi9fQw
         /+f8kqSf3c5lnPbgTOpjcaG+8HaS/tbNLsUNWfdu/zeBcOppDp/vBlmsrXQ73ffH0A0g
         3Y4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=TNWYX4fWsx1kIjs4XJw2DVzdzROxTXQiFtHEx6AEafI=;
        fh=236em7+PD70jrNo332o8KsZSSN2zwS5RJLZnTueZ7Vs=;
        b=YCDjCApIz4rUbUn5ZsicIWRmp8Ybw/jJ/fycK9EkXqbAe325ScjaJdfb5DB2v7IZBd
         mR/XtavuyUpn/XgB+XfvBPdQ6IQyhhsAv1HP83ZEApJQWsTMFO4BT7Bmgw9cJf/EZGDS
         7afQwCsuaUoHDTGUtwVJdZIEdR2W2j6/ot3Wl9mh/cYmIkeVfunU6MmL0ZAJpDbtCa4/
         3XxtPDRuaP3O36T7HgC1jioGRsPVsy9pU3mXSjfjPQZjlj72MY45iZbGCmaJm5PDwoJK
         JnFTKV5AFJMB9+4gs3E9yPDdjnqrBYtUwqpfGSQwmo2SihmtmNhg2AEfYxVyaifsTjB8
         L09A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791312161; x=1791916961; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TNWYX4fWsx1kIjs4XJw2DVzdzROxTXQiFtHEx6AEafI=;
        b=XP2KY62Nc21tspXZ0jtFoUUy045AUqVKGcuW7imBCzmlhxrokLSo5mVhUx04lOrZEB
         WnMdpiz2GK/t7+bEJnP5bXuNDbKpXmXH6tlbK2BqfM3NJaqUOuLrMF83DUswtJUONCiR
         +CyOPjhKbqLgIZu515cFBi0Kxe9aa61fGm1DGlGnWaCW43UI7F/goG0Oq6mduGsV3C6X
         m1EKjWSTgXQ5oY4vOTEzUCmQVG7HZvOa44/EYo4XkZNZfPoWxLYE/THqC6AmJHKORNXC
         VeK3rew//7+G24ip9RpneYdrEoNVkBL9PKiDJCop1njtueuDbnct9ElYBablBHc3DwpE
         XOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791312161; x=1791916961;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TNWYX4fWsx1kIjs4XJw2DVzdzROxTXQiFtHEx6AEafI=;
        b=C4HK4N0e81BuhhU1W1aBy9C1WSj1toqDKzyVRpqbZi1UNuIs+n9Lc5+zpBju5XsKdc
         tDANBfMSl1gJdAY4kU2vkiCWu/8/aHR+JsIas/fdy9YLE29+j218uEnF1hvMKaPzQol6
         GRMJ5PZF6r1k2JbzA795MEaWYnEAsbYgDINHF/vo69i5KijVzJ6hhyabCcGugroqA8iY
         pUVSaIH6r8aRBnc0mspACM5dNRz51s5hkYJ7jjHK8uAi0Pa/kqrepje0nHQ2cZZl4rxD
         tJuqWZNLW4/5ly1dJEde51oBA1DIlq9N7f6cFwT9DH9tVKTSvKlLzVlJL/lIqD+1RT5G
         0+nQ==
X-Forwarded-Encrypted: i=1; AKwUvByXo5FcklqqaFgkDKUNX7OUbXGhKX2ZPsHeoSYulxZ/BjXY45YyA8P3wNkcFO2JHte72ONLy2N1OGE=@vger.kernel.org
X-Gm-Message-State: AFuF++lupmVlfAFmJIJXPMSYrRT87r/8jGENa/annJ8c4cTl01nJOisC
	xyw+ZtETFx0mCGnAhIkGGvO3Gsa6fJF57IQJCvLBb9rizotlb2UBZWlpUqbzpv4VxfN0Nsa5G6/
	wLmHcLOOTH5hJLibTrfds0P37qEDmQs2erb/r/9U=
X-Gm-Gg: AYBFou2Z67m0zbOluw1bzx2eJXFxZfNSlwitS0oqHamXEIkp7P2h6I0hMQrtyTVOO7g
	KngE/TT9VzgbAONZhkm+BA8nqsFjFDe6EIFaK76s37FBHH+IchiPWPlER0fcnQZCmoJ/dt3yjFT
	hk4MVJ4ChgJKdINeIesnH+bu7zvszQz1GfYW5+YkueS6xNdOCX5wwzfWZPZjxWmUutL7GyiDGNo
	vit6nLnAlRcy9nf+3Ddoxomoq2Y9oy76VmpJvhZyYbH+R/JpT1/fn3maVt/WFGbZVK58l27TxiY
	N4zlMGHrrRpXVxaDolWdB5c6ZoPcmikfA8vwj5Bz0xz91eeY1caL87KsVqntmrpiM4yz7XKnQgo
	nII87MIuhMrsaGZx8sJJ2zQupH87uSq4oYDTW
X-Received: by 2002:a05:701a:c901:b0:124:748c:2ba5 with SMTP id
 a92af1059eb24-15e1297c33dmr34061c88.13.1791312159692; Tue, 06 Oct 2026
 11:42:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924173501.856380-1-dmatlack@google.com> <20260924173501.856380-16-dmatlack@google.com>
In-Reply-To: <20260924173501.856380-16-dmatlack@google.com>
From: Josh Hilke <jrhilke@google.com>
Date: Tue, 6 Oct 2026 11:42:28 -0700
X-Gm-Features: AclHuK-63AoTbyB-3ClbIEIaYMGnGi4ajlf3gZyouGmo8fAAGNgvYduwL3zAm7A
Message-ID: <CAAdrzjsz2hVMLTPJKtuRakHxMi7hGRr8_C2EsCjBX516tKTesg@mail.gmail.com>
Subject: Re: [PATCH 15/15] PCI: Remove the per-capability save buffers
To: David Matlack <dmatlack@google.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, Lukas Wunner <lukas@wunner.de>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, Sep 24, 2026 at 10:35 AM David Matlack <dmatlack@google.com> wrote:
>
> -     /* Buffers for saving PCIe and PCI-X capabilities */
> -     pci_allocate_cap_save_buffers(dev);
> +     /* Room to save PCIe, PCI-X and LTR state */
> +     pci_reserve_saved_caps(dev);

Nit: this should be "Room to save PCIe, PCI-X, LTR and VC state".

- Josh Hilke

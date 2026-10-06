Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C634A092E
	for <linux-pci@vger.kernel.org>; Tue,  6 Oct 2026 18:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791312146; cv=pass; b=LpBoEhNzvyV49jKUXOA+JmP+uppdlUZu7gy/lnPFntpfb9dRVLjOe7eDsdbIX6si9NHEqhcvw/YvcbhKinSQ+FcjdfR5E7WVW4ABTwpcnEyO2sRV2FEGlx+jzGKKLllW9zmo+8u86N1PT1oJlgOiYdDxKfx2ojx+xuxYogDwj9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791312146; c=relaxed/simple;
	bh=3VMIWgHBKgddpJfpGx7nrdOEGlywqbmgH7lAP8hvl2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y0L1Lcd2xnDZYtjs12J8/nkCBvrfEVzn2qc1aUKWBkYRKQc/nvPx5NjGiyMbfyeSVBnEaA64loDdw5CmBp8zc0APbHUCxh5f/MEmz3L1dr30/W+oH8E847c2UH1ovDbFgR14PMeAQuipBRVrWQPU5UPAZUu6eho3NhuGgJqmg2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OnND6LhZ; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OnND6LhZ"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-150ef97e790so2130c88.1
        for <linux-pci@vger.kernel.org>; Tue, 06 Oct 2026 11:42:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791312138; cv=none;
        d=google.com; s=arc-20260327;
        b=HWWzdlq8B8XiY5j79weLvaF4bYKONih02/O8pMcWG6ogBQdFe7cAu2ZsyBzRYhI3Tp
         4y5T1Js2z+tRI89nC/Xi3CSCsyIkQJifpFUF3TkFELm3OwAjS9p/SbNni1+kZNX4dIcw
         5nyXifOEpfB+/MA5pa/nZ9h+KwnDY1RsJ78+8ZxlND1JUrvwtqRHoy2GX89dABtYZ9fs
         io9VtJGBPZ4HXgGu7/oHK2V282sc8s20MhHAkf7sF7lHTIO4pVtkkfBs42awndmVXqgy
         J5DS2Z6Bn80z5ho4pN4LpvHn9K+tfQnHyHjqxeL8frr6MNZd2Xutq4eQCU7ZP14tmMtT
         QRiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PXeSyA61cP/YG1W7o5p7MScoynhww5ruZfkO1uzVkSM=;
        fh=WAULPN0yGwfrlnu2q7zgsJJjMIn2diEShs5BDZgKth0=;
        b=hLqXPxYqD1a9ZO387aLhNmPyBJQb9KUoKsUuU7oJHZat7qZ5cFhJhwNoxjdOmoA+5y
         ZA7jlRe75qbNlCv6J0vIPgrBGbbKauNO/58A1asF1dPJ0k/s/fA8HlSnBhPHPvaGL33i
         ztQ6NTkxIGthg2Lcwkn17xUqg4hlCa4qLbUiQYYw8lCjWBB4HwyYRGoey+TABfYj9nOM
         4bD4UsAGhdhDGiTkEBWHUonh2pCT0zM1xHrKiKInzgYMVo3r4i4ODRaTuqpDB8WBsHU2
         sZWkMtDio/7R6hgqdDtrqQQFeKp/xB3VvlUzLtrFqQ72WUN8Fhtd0nPTguxPjtI/ZoFe
         rvUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791312138; x=1791916938; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PXeSyA61cP/YG1W7o5p7MScoynhww5ruZfkO1uzVkSM=;
        b=OnND6LhZxQM0rXiS1Lih076HMnzenihuZXcAcndlzZyUBqj/fDX3CIEPTjys3p1jMS
         H+QKf1RNkJ5Y/b9xvOF7lBvlggvRxMlY5hPT4ZrlOrahPknzI6Jp2gum365ItU6NG8eo
         bZ3v+SkBSS2+57E3NmQkxFqBDICcGgRPNRS0uuTxA8aSDJS2OF1OUSp1ONNhxvMrxsNe
         wsV+zYOW/K1JuPrt0/wFMlLnRRU8r2ADe8YgZ2+igUrpFzDEH9ErqgO0CDWXIoY8uw2I
         T2NAUhqyLscMknQ3n6xuFCDOa/lKLw7SRP/8+dfqIivGusrDBJlZB68xU9wMJ4+qvzrc
         gVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791312138; x=1791916938;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PXeSyA61cP/YG1W7o5p7MScoynhww5ruZfkO1uzVkSM=;
        b=i8fd0xXApmUbfsI75fiCpz4lRb8LIeghtsL+lGm9872P3Bn7VqT1yLSbKWnWz6mBRV
         NTb9Au9xDlLlhr87Fjf0qYqlBOvkFRja5vntV654hVAbmmb5Er0HwzfkpcMEXPfFsqs0
         DbMYajIQhG8akhbv7iI/XnaONJr/EhXS4qsQ8BP6UhX1xHyO0kV3LF/uBrDoR5ZNqP9Z
         2uWOHuRNyLSnianyTDaO4YM/KZmyFrn3lZJRpdBYYWBKseLZOQd622/8aiB9kuylxv//
         RxZjdYT/VoZR0bHPfLKn91+m1WYzBynjtBnjP8Xi7uomfVZcj4/8I9r0CmM4pJxi2jo6
         SPHA==
X-Forwarded-Encrypted: i=1; AKwUvBx74OOR/AhTESwYC8Mt+PkwLdNRhpZKDc5i8l0A9kfWcPPu30zDM9hhfHivsaqUosLNUivw9NpZEwo=@vger.kernel.org
X-Gm-Message-State: AFuF++lEez7+kDYXyJNo68qXzQc/0uc4kakzfeo+LNhYiBQ61PIiQxqq
	C6znwwUZAosLmKbFRm+8VWsM3F4F8v1dax8BVqpI5AEMEnnKWPr3gmN+3E0EFVQzHb0Mb3ZMWIa
	Z9Jut6nkl72uEHmj8XaVCahV5+9xfVVD1WDswQPg=
X-Gm-Gg: AYBFou1XF7FN/5zlsXakAyL3wHgctv2rKLWKPR5UigJ5X/FkCIVHdAPkSvhylJLKAph
	w1ZOPZLLnxuPqRGCYiToa7sTrblsWQF2FgNJ5qsK26YGIRyJPgyYlDiJpWLpadCxyGmaTu42KOn
	43q4cKsavOB+ofxihKzp+ZKRtGtaAqUmMRJxQRjJVs6EbHgfDcbOuW/fQUMU9AZQfIZMqyC471v
	QaproftRDDNV9Y2jt/tnhP5WK8OWM1JYKMDjtsgfWR4LffbDbPPoYyU1l15uOpNO9+0KEsED8Bs
	+Vime2UQX/MpoW1ESevGmAQPLpC8kg5+b2WlS6qnpjYAUJuLizJBifMKb42Arx6yw6d9YT4aI3m
	ElgTT2/Mw1fGREci/QHAPt/h6JKox8/+q1f6u8Q==
X-Received: by 2002:a05:701b:2518:b0:14e:e4bf:7974 with SMTP id
 a92af1059eb24-15d7ab090dbmr488934c88.4.1791312136400; Tue, 06 Oct 2026
 11:42:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924173501.856380-1-dmatlack@google.com> <20260924173501.856380-14-dmatlack@google.com>
In-Reply-To: <20260924173501.856380-14-dmatlack@google.com>
From: Josh Hilke <jrhilke@google.com>
Date: Tue, 6 Oct 2026 11:42:04 -0700
X-Gm-Features: AclHuK9yzmvKK8dZq9avpOj6F6GskJ-F_IbrwE7g9TDd8JjXbHVrXV8aJ-JhauA
Message-ID: <CAAdrzjs1JkKJwcim7czNHAoq-u+AEGqgynNzmnbxq6Xk3LJCfg@mail.gmail.com>
Subject: Re: [PATCH 13/15] PCI/VC: Save VC state in the saved capability store
To: David Matlack <dmatlack@google.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, Lukas Wunner <lukas@wunner.de>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, Sep 24, 2026 at 10:34 AM David Matlack <dmatlack@google.com> wrote:
>
> -     pci_allocate_vc_save_buffers(dev);
> +     pci_vc_reserve_saved_caps(dev);
>  }

Nit: after this patch pci_allocate_cap_save_buffers() no
longer allocates anything, so the rename to pci_reserve_saved_caps()
could move here from patch 15.

- Josh Hilke

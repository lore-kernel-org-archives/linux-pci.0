Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304F8499F2D
	for <linux-pci@vger.kernel.org>; Tue,  6 Oct 2026 18:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791312126; cv=pass; b=jlC7bpGVNqd4uWA0muwPaAVfASPABG2gitvqyFmue64G8NKhCMD5mCUvPEi1lxGVQpp9C9bYmgSuLf4a+A8WWsJCtgofH+75JdYDa5VC3MzQ1Bf1u4YnBkyKHRkW+3/F4BoI6q8IncY8hVVx9sh9jbxVHM0Ft6gPCEKsWDhAb0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791312126; c=relaxed/simple;
	bh=VsySStT+bTHVUZ7K5MQkKgFZxIMQ6ua4cfuOsS0U3mo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C2PZTxem+67kP9D2MmGxhdgbHzH4ekzRNSZqy/Icp2XtrNkjU/UmmVUx4LwZLGNUCK+xMgKfufVsUNyGW0ytUgXQ3k3vQgtzI8xYSEqNWhxxn0XpzJCG6KTcxJ8/ALxBLgliOcmrWPVO5RmLCSlX3RiB0DYqM2383uJYSOFk12c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MVGZiPbl; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MVGZiPbl"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-143941c2aebso1227c88.0
        for <linux-pci@vger.kernel.org>; Tue, 06 Oct 2026 11:41:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791312117; cv=none;
        d=google.com; s=arc-20260327;
        b=WARBGLd5nZtOi9kfjw42oI/IPkIuqrRmIhY48fuLBqGUkipUTm/9KNvnv2CZtvmGSC
         EJuZTcTnKqqyTLskOnLb43SrmyRt1uAwwd4iCZEaMXJaMtHb31akXJ0OT/IPRNE1fhBA
         uu/TW1UY79HhgpGFwbyZOFG73ItS4yB6CnDt2UErlR8DBrXHiARDKw3jccqdIgWZCG9d
         qTn1YM99y3m3Q1KEFm8aeGkRy0nt1/2EydRG6btuzEvXECw5XOjYidZ1Mm7BVSPnHh4q
         zyVeqMl1lzlj64xGJdU9XW55/SREFxVEhwpf+WOc21WFum8QBuna0+2Pkfh79gcdidM0
         4FOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VsySStT+bTHVUZ7K5MQkKgFZxIMQ6ua4cfuOsS0U3mo=;
        fh=bDVMnr0Ejf33GIjRcDoZclzOWD8/1VWMLOdK54bQ3NQ=;
        b=bO+QxSckrJFYyxNQ9dNHrFfyt9a4KYgt1EqOtuDm/x3gmZfQ4T+6IBqiJp5VePsmKb
         7ugdfhZIFNPa8sEd0HadN1dWAKIazk64VKzAt0+9F2gUZCK36M93Um72RlTJmjHyHW9a
         e+RkO4HZr2KPiFmiECB80eLqKoG97Ue0jgdhjlbeL22NVXScw6UFfEkBghhcX9615RHr
         61LRzR/shh4DR9Ne2RofzAwFLrRfQpXJqw8ljt2CrM/WRGJ9tSWpZTUvoLLVZCb/BMKc
         sPJJj2pOAdG1/ypP9pn6beXUr8EEENGUO+z85Sq8yT4IWowieVv2vcrATDi82zICJ0E3
         EDGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791312117; x=1791916917; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VsySStT+bTHVUZ7K5MQkKgFZxIMQ6ua4cfuOsS0U3mo=;
        b=MVGZiPblrW2Iq1U9q2FPT1NPM5mJXtwHxtlLB5hLlrZvXSoxgYzAVvjagFeEGIHaCy
         W77CZythHwNcpuWQKrq2z/oQu4N0iJTSMUU2TsP8G2l2N3xdUc+rKNUqtj3dd9iR9p18
         jlRmAQBw+hgJKyXwjxkzyOybBhLQPy/hpxvUdO2GZyda2NXw5h3X170k/kQ/82pryEmu
         auTENj6np1yGJAKJnB/sClzPcao2Gx7Yzv9V/FltqmAN1qgDwdTtIagnz7ZVyDsEGoQu
         moIHFEJPaauE1wYvzgVvDg85LRpradPn1Ds9PUqYWIZmrLsCUHffYTRjpO2h0y/zturj
         j3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791312117; x=1791916917;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VsySStT+bTHVUZ7K5MQkKgFZxIMQ6ua4cfuOsS0U3mo=;
        b=pxQ2X1smmVzvgfh7S7td5wMYDAghZG5OTKkTZJfmCwZ2kInPMUmiWDZ6JNunW8yqmd
         S8m6TneH2niT3WCfeBja3YoLAYY9Q0jOoPpzgVwPIPxQDn2el5suFBXpYseexa0tv+sy
         cwSkJdCu/0+h/IIySYxrQi3LUw9riOkXZrD4ahRsZhsyerhHgKrZRYfwVj7/jSb1/3AM
         jqwH3A/cQ9pvqnHPA/0zQkzTTZHTxw62ezFgbDD+rPxPoerekxbuAuKaNS+gdeOAksuL
         Np/DY4ajmCxb76AtLmu34v0+eSfSSk5sk4EKt5ieaHViEWz99hkDivQeMpK4NopBGBBM
         5V3A==
X-Forwarded-Encrypted: i=1; AKwUvBzpg4uVrZyUY0rkevRqkc9FCAROGS2yjXrR5qK6P9fmF7eOBhTeIFJplQXApRj9vAckIAvimzXh2hY=@vger.kernel.org
X-Gm-Message-State: AFuF++mbfaJXX7nBqi2MGEfKUmFh4PhYIUY6zt4AzVPZVnQNSlDBjM9n
	25Gh69v3IGu3YILk40Thxx09seBdMtWvEYEjBnJYn2fRkZkx7EK/WtGYbUbUEocgrOxaUT3q/OJ
	7KHOLomUARUnXyDeJUeGVO3ILryY0EUeuUNqljBM=
X-Gm-Gg: AYBFou1xuhfQvSTAT0iebt85ezKso7HRErkFXV4189JyKkcs6wWesS8s2y42LFsVn2a
	qee9ro8/Go5UcMvjSzVKRvOxwoUG2aRS5FY9LIJ/YIVj7LI3oWM7WgXByKyvxZMN5H785/JHKAv
	ULSeO5tqFeqh+n8kffVkLKVS2GRdBDYAjq4sUqr2Z9M8QtHyLrVT2bDCfFQDN3k7hs8lA9ysX59
	9lFhcbKDj4vATDQiWIhbq0MvfbTgrVbbsHS6pSC1+HeESPxmHaUgUejf7pj7RTSUfRkQEsJ8RFJ
	2nBiL1aHz6M67UEYsCOMEGQ9dhCn6VwhtHRbiV/rJrBfomBASsFqcJ6/8KA3zHtGqY1ZdotCCRb
	zGoeWZ50lGEihbE9q96jt+5osqpYLRsMiOPob17w81ldLHag=
X-Received: by 2002:a05:701b:42c7:20b0:151:5aef:b375 with SMTP id
 a92af1059eb24-15df6a22909mr440182c88.15.1791312116126; Tue, 06 Oct 2026
 11:41:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924173501.856380-1-dmatlack@google.com> <20260924173501.856380-8-dmatlack@google.com>
In-Reply-To: <20260924173501.856380-8-dmatlack@google.com>
From: Josh Hilke <jrhilke@google.com>
Date: Tue, 6 Oct 2026 11:41:44 -0700
X-Gm-Features: AclHuK9XxyGsPYngcwP1eLyAaqdgOZtLG2-uiexY-er63NSOcNYsX4saqv5yQk8
Message-ID: <CAAdrzjs_T6PV1j-9n9vZFHLaORZQ8Py=g-Ms8F1hQq-NwPq9Uw@mail.gmail.com>
Subject: Re: [PATCH 07/15] PCI/ASPM: Save L1SS state in the saved capability store
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
> Reserve PCI_L1SS_CTL1 and PCI_L1SS_CTL2 with a single request, since
> they are adjacent DWORDs, just as the old code allocated one two-DWORD
> buffer for both. Skip the reservation entirely for devices without the
> capability, which the previous code could not do because it allocated
> the buffer through pci_add_ext_cap_save_buffer() before looking at
> pdev->l1ss.

The last sentence needs rephrasing. The previous code didn't allocate a
buffer for devices without L1SS either: _pci_add_cap_save_buffer() did
its own pci_find_ext_capability() and returned 0 when the capability was
absent. The explicit "if (!pdev->l1ss) return;" in this patch is
required because pci_reserve_saved_cap() takes an offset, and
l1ss + PCI_L1SS_CTL1 with l1ss == 0 would hit the WARN_ON for offsets
below PCI_STD_HEADER_SIZEOF.


- Josh Hilke

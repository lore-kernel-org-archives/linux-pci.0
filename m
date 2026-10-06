Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB16F4A49A1
	for <linux-pci@vger.kernel.org>; Tue,  6 Oct 2026 18:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791312155; cv=pass; b=sN3bJZXxImYQ/W/6cQvJa4CbdWXD3xfnYxWsQRXM4le4liRjBO102Khc0pq/Gw/wvEyHvhWp5w1J9Lwlg/f1suy24sbXIRAejzo0gYaxPAsbW6olu4Kb5CQzhKgbllvM/mbS/ITbP51hel7VxwY1YpWOvzxuLiqQO/QtVnTdcYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791312155; c=relaxed/simple;
	bh=lqvNoiYS5Y69wvqY92SOyBc105nfusymGn5er7L23A4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qieCnCb0e/q53n1tzv4udL1O4sCXOpfgYYo1bo7QQfNtSgEA+26ljt6yJL8jkhO8KiNah06x5CqhBNDPIQ1+zeIP7flMw0i2P8R3RHbcGWUUNIoI/PEMG+CzQT95j/zuCuiM7Hgub6cUoXPJKivdBtmoGqCxPHKvaJW9NaVmJiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qRuhekSJ; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qRuhekSJ"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-143941c2aebso1232c88.0
        for <linux-pci@vger.kernel.org>; Tue, 06 Oct 2026 11:42:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791312150; cv=none;
        d=google.com; s=arc-20260327;
        b=OD3bMpD0W9xRwk/oS0N/4+0P+UbDWjRDYwvKrp6cj1DmCayDnh/BvWiYDKYQKTtasg
         Vz/uKNPjkvdfvxej2saLO6WLNXIh0MooOONqksUHleVa24xFDlTGzuTT1JlScn5g+CXf
         +xoHdbsJxfLTgAoL/bKSdMeEiiBtpyVWhrhwTL99BX8Ps/9dwiYYe/ZoYq/XyLiomwaW
         7EPyptTz9z4i2zy8hXPzBUW4WALp6p0Wh5AtLFlATl56DILxuQw+sSZVdXtGLoUX80SC
         R/rZv37StFR0kFpPRovA9cXVsuX2h+8BagtR9GBqaKBOBwDRApM3xvIceTnlNusI7fL9
         ifpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lqvNoiYS5Y69wvqY92SOyBc105nfusymGn5er7L23A4=;
        fh=wLXXbgRAMkkbqN9e+Ra5hhtCAZjpHLa1k92lpGqHklU=;
        b=sEDsDOVDVDx3E7xZvjQ/m4+rkTsnxg6Dji6HxterOMemSxblcNdcv829ZmJJYOeafg
         Z0AJHeYpD21bKo6wtdojNZpolz0vyqx4ruCY/Ca3itjCZXvMa+LjK1TLW8YNuMRaMsuX
         ITO+7icDZw/PMI8X7b+w3GQPvR0YnEnP9Imy3Ws2SVB+hQXb7N08FBTZB1eGWJn8LeGD
         22Vqfw2Eslnal6iXADC0WY3UcuzSKBg+GFd2zF7Z/A80mMdNMxmkUENsAqSMYKZdESLy
         BKHzoAwIOUsqV2utADfYNej6Zyw0fES4+L9AAAr0yX75qKFHJbV6V8MOrxcwN9rRJrRt
         vSNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791312150; x=1791916950; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lqvNoiYS5Y69wvqY92SOyBc105nfusymGn5er7L23A4=;
        b=qRuhekSJzdk8i+DAJXACJem5G3rR0qUhP89PkDKWJHgX/bjYseCW4NnsYaO2PqXJ7x
         Dw+DFfO4QxlsV5WnfGSWIFKlOmxJ2h/z4rb75merTJtFFF9nkYAOW3S9rprOsOzzR1TB
         uNCQ++6SHFcQDZ6o/zzqPS724Ia+x6F6PNK1cq8socjV/T9zTxFqzjI56UBIj5aInwS2
         MsiGXBi7FhIApDWuN5ajoadp5vG+lkOxtduprNLFVYzPB9DaJ9vWZYQOzs2WWgRo03ML
         N+4UGeQHmQ+2RbC+/G1uhXJHN8zFufwgwzMYrFdG9r+dqoUBizU/IhLyf0CWCLqu3yht
         NPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791312150; x=1791916950;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lqvNoiYS5Y69wvqY92SOyBc105nfusymGn5er7L23A4=;
        b=ZaPMWxKfGq47pEVgMmaoeTQnzn6usZ6SjdzaRDvolW/TT0yNClrwPvAj6MW9oVQAkq
         HtDqliZApUTUF4FiIm6Yu0fILOj74vJl7OtXsYqetqy0qrmH5DUZH9uAdM8t0mppgsQu
         qhSfEbwY1HJJ7L6bvJX71kif205CpappO2/kYJmEg6IFirhEuVQelu/aqTly4zGqFl5d
         6wYdSWFgVNXSi0g0wOjdAy3jHeQBYowM5gVONgHy9gxkP6tuJ7as0kEtM6rv1VTijddv
         /9tSEHG13puGO2nGYWEtiRut7fgRMqRw+VTGXX/OhLrEEC1N5cSQVFsDgz6iiv+ie3TV
         4UQQ==
X-Forwarded-Encrypted: i=1; AKwUvBx/DJme/zsqvaQRw8iTzDJNcTtChWHXlRIofMK7iVEW6otLBz92eHq8BQxdPElWuBPyczjqtq3ozRU=@vger.kernel.org
X-Gm-Message-State: AFuF++nqQWaIuqjU9iazbLtx6iNlgxb7dvo51EOFjC1SLUISshDZeL0m
	HgDmmpFh60yVF2G9ri8tQgGRyOBUIAWDWDZ9Y7OHJYn9t8/p8agVon1Mk10bb9QC56tHyPmjpsA
	JzH9/9uqUXZQFVGOBw+yTrH3FpqANwVHZBFO/RvQ=
X-Gm-Gg: AYBFou2SFUaqY9kn80xnpbeooS/lIq2YtwYd88hLacG0T2BcrNS/6aBOLMmKrqQnvnX
	SjrJSTIedOLH2utojHJ3OD+e0hIGGS57DMTqAHoSGpSu3wwSihH5bqIniDohvRUxr17/3vidGDn
	gxqO0rGpwFRoJVVLwprWaen2HgL0mBzIDsyfeQGR2Qbcap4xYJShNgDvPFuhe/7r7WMKLAs64ES
	5nehkOPiGM9rhI0ZSOtL4jM9KDNbaVQYTfeqkSzuEmi+l+RtNhVuHJ38e98Nu4HuMgReFbn438d
	tK9yM8DhCzTlDUzLVrZZKEZfceGU2oyZ1lEEjRoe9vdCVl0CL5URGVxbc7VQB3B1QxgHN1z/UPz
	DoMiZEkDerHzvZq8d24HN9w03na/CA/XmA7ZX
X-Received: by 2002:a05:7022:ea86:b0:149:8916:defc with SMTP id
 a92af1059eb24-15d6b02a69amr459793c88.0.1791312149393; Tue, 06 Oct 2026
 11:42:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924173501.856380-1-dmatlack@google.com> <20260924173501.856380-15-dmatlack@google.com>
In-Reply-To: <20260924173501.856380-15-dmatlack@google.com>
From: Josh Hilke <jrhilke@google.com>
Date: Tue, 6 Oct 2026 11:42:17 -0700
X-Gm-Features: AclHuK8FvAbBzT1AuW5uRxJ-kZYYZwS_oOXm66BR8cKM-gGDFIVe-GGMjbHDU-s
Message-ID: <CAAdrzjsQ1v1LRCcikErDSy67=SNDiP5qvNTr8W=qjzXy_wUWag@mail.gmail.com>
Subject: Re: [PATCH 14/15] PCI: Save reserved capability registers in a single pass
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
> The PCIe capability is the one place where this is not a pure refactor.

Please add L1SS on Downstream Ports to this sentence because it isn't a pure
refactor either: before this patch, only the child wrote a Downstream
Port's L1SS slots, in pci_save_aspm_l1ss_state(). Now pci_save_caps()
also writes them whenever the port itself is saved.

- Josh Hilke

Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63E73D8110
	for <linux-pci@vger.kernel.org>; Tue, 31 Mar 2026 16:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774972951; cv=pass; b=OorfsYCGsNfppBWwEqQNLSfcnj7aPFLZKVrn61+ilYiMyZ2keOJ1z2/VdBNVifdfnD4twWHKftbgisJW8qAseywyHCcfm5xp+kzY8RRYClyHvm73J/p65kwGPqMmpcaJ4/gJ/W+qW5mtaW95zIiQrm3bqeEISwIlF74KYu63eMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774972951; c=relaxed/simple;
	bh=WZtQxxLzyCHf/DgmHeqOesM7hpOg4ow3SPr9YUGqw5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ED0SUj6LC9Hy7f7DBgn8ZdPIBNm5ENCRftaW44RXSTPf49Fiz5R1IHwq7m6Wl7aQL3J3S+AmQkruGVpg0t3wjSk/2vEck0AFHJzZS70ldY6c5e2S0cU+3uahrgjo/i4+5o7FsCnxJImPk+xj/Lqf/nKn/sV5DFucn3HQars6i1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SwGZp8W9; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SwGZp8W9"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a1443780c4so38869e87.0
        for <linux-pci@vger.kernel.org>; Tue, 31 Mar 2026 09:02:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774972948; cv=none;
        d=google.com; s=arc-20240605;
        b=NI8D6p0S9TlQXQV8T3kblBV/MIZBfuG41pGV7rquYPdwAfpnkIGaOUY42eNOmsmIVC
         dmkfa9HWjJaEp2Btcuonvp+pU3Zda+dA23Bl0wbOJGAPvybtKqMLkFI0mllmuELVuVgi
         S0QqEcgBbcNT66QRdtfxYDaE6SzeEkquuTZ4LWXPaYo57ZWGU7WzrmiteVIpV0oydxJl
         RG3kXgR832YFIaHJit2iAqhB2mJQvugXLafWUojitD0etTF1xowiaJGK4r/THGZYkgko
         ft1RjehInL/DUyoSHr3ZSN7xEzdhglFGCxt3Xx0W2VXip23irUghW1sJubr8sx4QX5dS
         l1Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wrD6nvT3KRKZi4VALNwq3h0HwShxHcdoRnQ5K+G8udE=;
        fh=nBnPKa0MdhlhDPnl62eW5H8UG5tI29V2+Qp1Dhygf60=;
        b=fnv54+qNr3RZdO436SZZMuarPTwwrw6I6uoY5juie3NNUqYscQGgNVqCCwheSWBVSx
         YPnoxaA7g5cWphK0+7z9ERE2Uy+IdiDeQZoPqI0MKZua9LM/VtdUcB9RLKt7icglvrz1
         G4JfOBSAcX6UTfMpmMqBqLREQGsfy8cgmMfEd/axnk00auChJysG62ecQkAB76rbvvAd
         MhsD7unVW0YNfG18OdK8ebRAeksA8iKC2HB5gfK25ieePBL89EcMe72kG6hph0aFbPOC
         OFyEzQ0a8AKqDPusPiIvZzwDwUXgBwWF2+ZabqUFVgrxUpXpiHpc5c4OXnq8HoaYtNg4
         720A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774972948; x=1775577748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wrD6nvT3KRKZi4VALNwq3h0HwShxHcdoRnQ5K+G8udE=;
        b=SwGZp8W9lJORAB2DnB8pLIX3sgx2UKo/jOtusSDP6qXVTh9I30U6Z+vHf/j4nqJY/t
         Y1qETmX/zjMLP4o3zzZl5GhJvQcBt9B0gk+hc5ePfq/XtmNHb4GI+ME7cznDcFY/+Pzc
         Hc6QbzlPsFFYCO81Q26j3IuiDnSRkYQguTcYZjIqs/FoZPPAXmBp2Bf9u5YIcMcBRXtO
         pnQ6U5q2BtZsKClPmu6S2KNCv43lmKAsjCDJYqCtMjzzrqhCHwObyWydrlqMG/UqwMp7
         Gle/lhsEdWB7s9BkTEPFwGBA2TWrxfcTvZ/duiKf2EjUAyYDOlQAFSgpBIqARbt85R+H
         jAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774972948; x=1775577748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wrD6nvT3KRKZi4VALNwq3h0HwShxHcdoRnQ5K+G8udE=;
        b=PTIuNu+sWZRzpsvoEVOLo/0Pm/Nt0ZHf2f+HFgdJUSg8M2xp1qjlWI1AOFIEn4dDIo
         A5nD2TTPNy6nZGunezlEjxHvrpXTs2lXtNqnmFdxcl7lZW6I2vr87GyZwI//BOGx2gHO
         gqUhN5w5tD7TiyZbiez6NZ7oWeVbyTaodAtFmUEwYXou4eLN/bwALtuR5x9yBejVJp2O
         CU+kTKKhLJahtkhzgtWslp8DNtm+QMJO5NjkT9l5cYVQujh5ZF3pScPSLgDWspW+ecy6
         cOFhZH4qN5bZSXDDw4FN7Vc0ZaF1HGeJ4fDsSSZaG5cV6Up0MRViICa7haLKw6L0zLxF
         IKhw==
X-Forwarded-Encrypted: i=1; AJvYcCXZJQq1g6zElDEUg2ALqstqoljcvJcbmiPuOTEgOSrFdCHX/ZPAIyp/83SaW7dG7e5wBT2pXaReanM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2qVKRFGX0RKp4gmEC2LHK8StFHlcTD5KQGYJXLrgV/PScYVwR
	25VKR8flw+S5QhbQ00FBOxguU9McSAHh/Hev9bXz/WKC+unbbAiD1CI3Y/TcSytVUS4HssJ5BAH
	eIJZ+5Nu93hTSVucP8PXUjDJ/MEeFFfVCLa94GVws
X-Gm-Gg: ATEYQzxAh2/lv9qxwmNCMDKorBdwn3sZeKImaBp1UzKC8dBY9MC4bUD9XscaLYRdN8r
	FIgMuqnO30y1IkDeZ5J6x5BEPeox4z3WRGbasPQu+ejNi5Bh39NULHhmr2xX+jpIH8PjqaXVI4y
	MdImDTWWUNvKTnJKhNvEJs6X6V7PDEYehh6GnxWPbsgi1msVrE5F7nH74c1gUeaIP6p95eB/J2f
	JItCQp7+91iakD7Z8nur4CCt/j75Mu3OGDKN1MoorEpzgeu1fZSi65+opix1CdhL7G/wGhWW4m6
	pbDPFMc5
X-Received: by 2002:a05:6512:61c3:20b0:5a1:5994:2773 with SMTP id
 2adb3069b0e04-5a2baaf0e36mr1048359e87.14.1774972946010; Tue, 31 Mar 2026
 09:02:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327211649.3816010-1-dmatlack@google.com>
In-Reply-To: <20260327211649.3816010-1-dmatlack@google.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 31 Mar 2026 09:01:53 -0700
X-Gm-Features: AQROBzBq0aIeqm2fBl0knok4yA9hrwjIKJSZaJ22yE0ZJ_GkQ8NeCmNeXNLWWlM
Message-ID: <CALzav=c7CuJmRjW0-KVk013r4pZZ_CsRtApn0rw9py9cTE-K+w@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Disable ATS via quirk before notifying IOMMU drivers
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Pawlowski <bartosz.pawlowski@intel.com>, David Woodhouse <dwmw2@infradead.org>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	Lu Baolu <baolu.lu@linux.intel.com>, Raghavendra Rao Ananta <rananta@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 2:17=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:

>  /* AMD Raven platform iGPU */
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x15d8, quirk_amd_harvest_no_=
ats);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x15d8, quirk_amd_harvest_no_=
ats);

Sashiko found a bug here that would leave ATS enabled on this device:

  https://sashiko.dev/#/patchset/20260327211649.3816010-1-dmatlack%40google=
.com?patch=3D12646

Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A452F617C
	for <linux-pci@vger.kernel.org>; Sat, 12 Sep 2026 04:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789187578; cv=pass; b=Lv0/csT3juo8r/OgtI/+/xtpgM6iWmuh1mn7bWAHDTKbPKlrpHN07b8+u+1g93puyF1qugfcUOEEubioLt04mFn9+HaPZI5zluAbJI4niWA06gqLGqI/558cFWJElbPDpJ6cwDaoWqNoPlTk86/PGBUephDRwGp9Hu1HoqAeRcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789187578; c=relaxed/simple;
	bh=vJxa2A/3rOOORvzNhRcBlzIBKMNk6f1s0vIeCYqnmPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lje95T1qyyAtFnVOACeApS8vHY2wdMSkBTlgYrxLOa+FPQ3Ae/0CjfXL2kQwY9gL4nHcArqIVF4o6XJNQzDjORjcfsQvi9OOSlv/BtK+sJ5oahKXsSycKOfzJ4DgHXLPTLk0yuwE3hgb55jLfaAk++wqenuMr9TRtFMLNGP/1ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YuHcBo+Q; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YuHcBo+Q"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8692a8568e9so200369b3a.3
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 21:32:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789187576; cv=none;
        d=google.com; s=arc-20260327;
        b=Az90RoocDgvOvhRUdsAwhHOV1bU8gb4WUjv//H9kUXtr5YnqEDXEPdn/oMCz1q6TZb
         tIOhrLolEPoTbVRlLZEj/dWM6xZ3AMekcthFkE+K8eQ/dQomebm+0GL7ZtV3soJGc1zY
         B3HLVvLKGy/ywoqz+J9cy02H/Sjhcy6SB9a5sAHAEaHYn2IapdzRSgGPHp4FxAz+Y/4J
         RAfdXGAN+RUOuv+eXL8ubi9BzH3JS7fFNjwr32VrwaGHilzzEMp6FVxd6PunJfP8EeEn
         jFVtCx317NQJmb+mWrUxy+oDNvDbAUhFiugeN6y0dwEBsunopWu9M8dCeM7HOeFYZtt6
         gxMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vJxa2A/3rOOORvzNhRcBlzIBKMNk6f1s0vIeCYqnmPc=;
        fh=asqO4hiTCIiEGk8hDkKCAEGlNk7qsNWrwBzr1vogfwU=;
        b=jVslgUdC4nf593a3C9SUQnlBvmaEHuznOVHbnLuZOVV77UzxoSumZpvJbJ+04cNX+c
         ++8L6RftX+C//0D9fuDE3vw318r7lxlUqnbD7Z1wyDb7wfM+pzZKxBJATYe6Lux6Fygw
         +1R26SDfB4lIesvZv+TZz0h5d3bJgrtKuSIvS949T0aD1YgdNjtvsxQakjV66WqO/H07
         ceRZFOfJt2LYyrp9U0vKpMpJkSTTo1JqGMGjWNfkWPRszP+DaJQDBDuv5LWUmDuscYG5
         IE3tQo8xmsKeLrXbS/YD7Yumdx46CCQhOMp0DWLta/p+HKiRGy8/v2czuuNA0z6xO4PR
         7NAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789187576; x=1789792376; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vJxa2A/3rOOORvzNhRcBlzIBKMNk6f1s0vIeCYqnmPc=;
        b=YuHcBo+QeGndKfamSszK9WPfkbor+lOXuRfip43WQrQLCRVscGY3ywaPXoB2KWCgVx
         ORz8EcQCGRkuTCP5XcY0ZWTWwviyiF6Ze0Yth4j2KteM/12DAfw2c/t46QBxoVtnrMjM
         6dSx4149ZTHP19Ggi8z+Mlf+FTRdWvtP3aV4vk/nwwA2/uJXWCsJ50cIFApwS/KvhKXo
         r+afkKFduo4qV17i8EJHgowASSz8m48IiES7qWeYiajNhLWpg0e11pkCugTmZZtr2vvQ
         NGCdAypSY9nWH3rOPjQzUriNCH++qaVd1Pk486XL3xPGdNure/3PaWLZU2/yO7M5MsU1
         LP9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789187576; x=1789792376;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vJxa2A/3rOOORvzNhRcBlzIBKMNk6f1s0vIeCYqnmPc=;
        b=g8gdQTSHlCVYlD22QEuWrCdFdNjLuzYlJGQe6QyPAEzj8OgBA05/evkjuhqOwJNDtc
         GQliVhUuAxVxFETJfB+C+aEffbYBRI7wPRoKCkntqXKMZnjLCry4pNSp5Aaanij0ET3+
         HopCYyt8zLQlOlAMjTIfKbdiwo9SEoQ+uUgDoORDhAvx1C9llqUPDbgLMCHAj8RfJAKC
         em68c6VLoaqUxceXfBV5WKkmFy3eJWjoG6+4MZxH14njSw+zbs19nCnUwc1TWRhwobwx
         rATi+OcGMAMmDzOUdXOK7Io9WNNoNJddANGp9r1eV33SIhDVVSgNuKs1EneGzI011/KB
         PjNA==
X-Forwarded-Encrypted: i=1; AKwUvBzTpQqEJNDk3kFAeVHJWmrbeJTwPNbaKIRc/hFDgt8HtUdWLL8NsCfO3DGZKyd7WhYEjwHfpyOoen8=@vger.kernel.org
X-Gm-Message-State: AFuF++lmcXQi+sssaIg2Fvqf2rqHaNMOIAo8rNOhvv+hGLKzvLdIpp+f
	FEbmDbN0eDbtGO7rTv6sFpiEA0shpFyN4wm/gouiCINz/HsYXsmmE/P+j+ktZyMO5wFTj8AVpe2
	Ti5skCYb/czw/lQN/Imh2hB+IjvxtYCo=
X-Gm-Gg: AYBFou2OISwNw5nmK+BKT7yQl0KwNd3EXvsklErrAoR8AwbALcKIKrSiwGOpJ9PgTKa
	oTmL3rUW4bHbaziLGCAosK4HqmdiO0lwwTgXuy4RugNCMXjsEhZK74bvn/v10mxS54t2K3WYAee
	oRhPYLUqpZniBwWK0Fm1Ul00wuFPRnmnNzaO25m8DgFOQvxBOQRawZkhHx9UsNKc6UxQwRH6g11
	q1PKIdElmMbGn0bFoRQ9sRT/0EDjLdqhUewNAQ/Pp8g7onabj6uiYSpDAATXmwCXgiePhMatIPo
	By75r0f0oMCizKl3f5eae2AGdmppb14J2PmZZhooXz/NdxlAYkfUbtJnZrQoja8A82U2um54Kon
	Y4gdZR8w7so8BdmF+Nu2CPYQQ0T0rr2OPg4bcRBAJEHGiiz91
X-Received: by 2002:a05:6a00:9286:b0:869:9298:ba59 with SMTP id
 d2e1a72fcca58-86cc58b3feemr1893927b3a.0.1789187575535; Fri, 11 Sep 2026
 21:32:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807160526.379-1-strst.gs@gmail.com> <20260911191429.GA549927@bhelgaas>
In-Reply-To: <20260911191429.GA549927@bhelgaas>
From: Semih Baskan <strst.gs@gmail.com>
Date: Sat, 12 Sep 2026 07:32:44 +0300
X-Gm-Features: AcwNN1UPlx4zHiHBwu2SiU3dxKzddih3M0ikGVdRzc6FKwE8r_Mspr0-EsTYEe4
Message-ID: <CAAsRjR=F7_7M-_tC_u1WRxB4Toj8nbcQh0WeXuNhzCQAs=vbuA@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: iproc: Use the EROM outbound window on BCMA
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	rjui@broadcom.com, sbranden@broadcom.com, 
	bcm-kernel-feedback-list@broadcom.com, rafal@milecki.pl, 
	florian.fainelli@broadcom.com, arnd@arndb.de, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	rosenp@gmail.com, rani.hod@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 02:14:29PM -0500, Bjorn Helgaas wrote:
> If the EROM supplies the information the driver needs, why does this
> BCMA driver use DT at all?
>
> AFAICS, pcie-iproc-bcma.c doesn't use any of the information from DT.

It doesn't. need_ob_cfg is set only in pcie-iproc-platform.c, so the
windows devm_pci_alloc_host_bridge() parses never reach
iproc_pcie_map_ranges() here; the applied patch only had to get them
out of the way of the EROM window.

The follow-up keeps bridge->dev.parent set by hand, because the wifi
nodes under pcie_bridge0 in bcm4709-netgear-r8000.dts are resolved
through the root bus, and frees the bridge itself on the error paths
and in remove(). The one DT dependency left is the IRQ, and that goes
through bcma_core_irq(), not through this driver.

The follow-up is in reply to this mail: pci_alloc_host_bridge(), nothing
from DT requested or handed to the PCI core, request_resource() and
release_resource() instead of devm since pcie->mem sits inside the
bridge allocation. The ranges property is still read, but only to
compare it with the EROM and warn. That is the warning Arnd asked for
before v2: the same property feeds the platform driver on the same
nodes, and on core revision 0x01 it is wrong, which only a BCMA boot
can notice. If you would rather the driver did not open the DT at all,
that check is one separate function and comes out cleanly.
Both shapes are tested on the RT-N18U (core revision 0x01): the warning
lines match the applied version, /proc/iomem and the enumerated devices
are unchanged.

One thing changes with it. With PCIE_IPROC_PLATFORM and PCIE_IPROC_BCMA
both enabled, a core revision 0x01 board now gets a second probe from
this driver: the DT window sits elsewhere there, so the collision that
stopped it before is gone. Revision 0x07 still collides. That
configuration does not work on revision 0x01 either way, since the DT
window there is one the hardware does not decode, and Rafa=C5=82's DT commi=
t
was tested with the platform driver, so I take that as the intended
path on mainline. It is in the commit log.

If it is better squashed into 552aa843e4c5 while that is still on the
topic branch, I can send it that way instead.

Best regards,
Semih

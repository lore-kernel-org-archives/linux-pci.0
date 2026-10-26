Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793026647;
	b=v0cV/xJ1RHAPmbHRayF05TdQtUpeyGfsSMg7zG2PgUSh+DFa2Bvo/eooDa+cFdrVaNlN
	 TOsEsYFeonFlhCoCc+x/4I/4t3QPJGiUY8cRGaaLsVQYZ4f8UPb9LyJ8uaXhSueuW8oYn
	 fNQurlMW6U9x6L6faydjcAo6Q5wmI/xj98Hde+J0/5tGXukXW7ZVHo/Vc9LduHJ8FUZ0m
	 peppEeLYC6NM7iBNgd0qbz1hYXCLwJFpM1J4T/gJh1msWvigYjxeBmQubl1lZXjghtfER
	 yqDpWLbn+K1AYER76ARdQqXJWkLSJXRBUFTqbEu6rnRY9cwhRucKvQhjRQ/3FbLuLIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793026647;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=EtKOfsTAyaPtV1waU6HbA1vsCK1xlnynFhw6+u4iHx8=;
	b=Bh3F4Bvx6Ta6/VWDiL6FRl5iwuVcXHd2SMMEhe3mv3yBylEjtjh4iyP5Av20oVxZiYQj
	 5eR/fg8IRhiAsgx1jq+XjwmbowwyJ9r2CgriNNnEWE/EZ4cu1PrtwcQVPh0RiJhKWWkj7
	 MZEVyX8bNKieMc4/YLzbSroYv2aQzu3AzNIt5+YFAOtkfnDXrl5fXUVr7VTR2ss1kWfMS
	 cFdKxJ5YiqF7x/eDu8rp1PV6z+Y2wBqp+5CG313zfNZZGEks0+6mxc/Et3jNaJRNw7naq
	 dbijaPdAWrsu4xMQIGxredpbumMGKeIJWzbQLZMFmD8106eoEnPq/c3H8a0+pz6Qigg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=AY7b3CLw;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B5C606A31B
	for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 14:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03B5C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=AY7b3CLw
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a2d6d01ecbso14572145e9.0
        for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 07:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793026645; x=1793631445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EtKOfsTAyaPtV1waU6HbA1vsCK1xlnynFhw6+u4iHx8=;
        b=AY7b3CLwgywyBpBReinIxBM/g7nwl+q03KPQCh4GovNPZkxq/jV/lQYe0K3X013dpY
         mXNLD9xd1fIe8yKwMntgyJncYMaLNrULAHE94S3oRJws+GDV68KQwOtZCErC9yaMgBO/
         Pa9m+pUjYxbHQ4sChqznZ0OG81ugyZdCPA7NkdbsiOrqQoBTMfawheCyxBjE4gcEt8b1
         N523KRTTJPqoqPXJMkqXVYmmX0DGAR6Xp3jy63/6p8iAPGg9oPkC7UEMypZWrNKe1yKr
         JihsTu3rhtaAK3DsGPBA7c2Ixf+C0+eTesWxXTXkXMkfie8vtFkQ4nQuPsJmRha9eJYC
         IGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793026645; x=1793631445;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EtKOfsTAyaPtV1waU6HbA1vsCK1xlnynFhw6+u4iHx8=;
        b=0qZK7yTKuDXQHQR5xDyM+M9fgvgUq4xE7d2dh3i8/HsQFNs5oHxEe/ucYkoOBI1U2i
         nBsjmHhhzwpjcYe3n26+f3qOzci9P8sN80efUaR4yhdyq4UyK5J4nQtYgBR1YhGWGkUQ
         RItWGsr7jd4TqghGCi+xBmgWbxaGyom75Mmc/tkAlaeF7ggoxVTmRwpJbKo1V1b/Yq+l
         IXi6Y+jgeFtBRX7Gh1rg1XPA5QUmVTlmsjgjMMV1kXxjm/uXhV/IbvfWIfkRB+LLvL/U
         Qd7AP6ESW+TyBO7jr9hI7WkhiBlLp4qMBFAScdvhc3g6bALNZA6ronOjhxLy23Ko7V8S
         DoSQ==
X-Forwarded-Encrypted: i=1; AKwUvBy9q6unPVw5XQT+s0aMmW5z5xJyc8askmtE8KkwUXsDy8Az8T7fI07f1XVEt1q8JRRYYcNS2EM0VXQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLeQPli1vIJVY1Li0KPe2bOCnwnG+bgvv+YI2u5ZN8RU49M6nqG
	/4hwdu9K+Rn17PkNnMKw6tJ+tLnsLSxAoh+j67YCAPagelx4hVgNwgeV+gIG0j/hufM=
X-Gm-Gg: AYBFou22f/K428Y7xEv3o8cL7VK5k6ztDexlpXrI39cBC/l4T9DjsapuDTprVWtI8V5
	HyuzGiKKjGtDws7OAbbXsLKFmFwKzhfOpaRRinVF7wP7Lybv9yMh+A2mBHZL86Zxc2Vl80nVwjH
	GWziztJsLfN/InVZ19LpYbD08Heijir5yM8A25qKBhctUcmLczlK/t9aCAPmuIYJ8j8dPIjO72Z
	E15vYvm/LIMG8g8HV3mwpXdaGJD8rACh1RJJzlP26KIQpIwgQ6PGfO874MiTzYo4HEV5i3Gz9Jg
	YANzE4eOiaMab7Yh0iliXLfsd02GM1P3yUcrh47mK31nDMmki5XMz+SbDTv22RQpGQjl40g1+AW
	sBWsw9l4bpHmBDr8hVl+/iKsN2EIWB2DksRFyMu45Wd55lOyelpkBHCsMvyedbLqH1QQrLbjtvB
	ZymORG1dOQRjqRaolTEgIhGvnCZRd2c5CIDTjjMdN3KjwRE2Tedi3Do1P3p+y242E4HV9hirCKG
	L/d7A4OuxAcQMQgzwHVFlJgq27+s/bYHJpR3o9FHw1vuJbRaJQM7NkU
X-Received: by 2002:a05:600c:6212:b0:4a1:742e:3 with SMTP id 5b1f17b1804b1-4a35acdd912mr122317075e9.27.1793026645205;
        Mon, 26 Oct 2026 07:57:25 -0700 (PDT)
Received: from localhost ([82.192.120.214])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd354asm16082701f8f.43.2026.10.26.07.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 07:57:24 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Mon, 26 Oct 2026 16:01:17 +0100
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Alex Elder <elder@riscstar.com>, bhelgaas@google.com, lizhi.hou@amd.com,
	herve.codina@bootlin.com, daniel@riscstar.com,
	mohdayaa@qti.qualcomm.com, lbiancon@qti.qualcomm.com,
	mani@kernel.org, robh@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] PCI: of: update endpoint ranges dynamically
Message-ID: <at9rPUyR-X7bRgBz@apocalypse>
References: <20260924222444.1351466-1-elder@riscstar.com>
 <ase6toUhGn0XD0v9@apocalypse>
 <223c5189-bfda-4c63-b09f-4ebd01bd144a@riscstar.com>
 <asju_HpgXpIyAFdf@apocalypse>
 <a8f7eb6c-69d1-468e-b7a4-7481e429c1cc@riscstar.com>
 <as9CMO8gODU-jazS@apocalypse>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as9CMO8gODU-jazS@apocalypse>

Hi,

On 10:49 Wed 14 Oct     , Andrea della Porta wrote:
> Hi Alex,
> 
> On 17:30 Tue 13 Oct     , Alex Elder wrote:
> > On 10/9/26 8:41 AM, Andrea della Porta wrote:
> > > Hi Alex,
> > > 
> > > On 10:55 Thu 08 Oct     , Alex Elder wrote:
> > > > On 10/8/26 10:45 AM, Andrea della Porta wrote:
> > > > > After a quick test, it seems that it's not working out of the
> > > > > box on my RPi5. Let me investigate a bit to see what's wrong.
> > > 
> > > I stand corrected: it works perfectly. So:
> > > 
> > > Tested-by: Andrea della Porta <andrea.porta@suse.com>
> > 
> > Sorry for the delay.  I'll add the above to v4.
> > 
> > > I think it should even be possible to tweak the static RPi5
> > > DT in order to make it work dynamically with your patch. Can
> > 
> > I suspected that your static definitions *happen* to work,
> > but I never took the time to confirm that and understand
> > why.
> 
> As per your design and as expected, the static range is preserved
> since the conditionals make the function exit if the device is a
> bridge or it already has a ranges property,o it all works as before.
> Right now the RP1 is acknowledged as a PCI bridge.
> what I meant is that we can maybe amend the RPi5 DT getting rid
> of the static ranges and tweaking the reg offset in the subperipheral
> nodes. I will do some experiments with this, but not now in order
> to not clash with current downstream DT. Definitely a thing I'd
> like to try in teh long run, though.

After some experiments, invoking of_pci_make_dev_node() as quirks
for RP1 PCI endpoint and getting rid of the ranges property in the
endpoint node makes everything working fine, which is very nice.

Regards,
Andrea

> 
> Cheers,
> Andrea
> 
> > 
> > > you please provide the relevant PCI DT nodes (from PCI controller
> > > to pci-ep-bus endpoint) from the output of:
> > > 
> > > dtc -I fs -O dts /sys/firmware/devicetree/base/
> > > 
> > > taken on your reference board?
> > 
> > I'll send you that in a private message.
> > 
> > Thanks again.
> > 
> > 					-Alex
> > 
> > > 
> > > Many thanks for your work,
> > > Andrea
> > > 
> > > > 
> > > > THANK YOU FOR TESTING THIS!!!
> > > > 
> > > > My hope was that the recent change (to avoid doing any
> > > > updating of ranges property unless it was found to be
> > > > "empty") would avoid any trouble with the RPi5.
> > > > 
> > > > I'm eager to hear what more you find.  Please let me
> > > > know if I can be of any other help.
> > > > 
> > > > 					-Alex
> > > 
> > 

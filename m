Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FAD233722
	for <linux-pci@vger.kernel.org>; Wed, 22 Apr 2026 17:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776877996; cv=none; b=IWThamJc1AjKFj/snihLBLvuahgU1KsDtNaaIF7MiYnneT0emFmeYE/sflaTcPKSZEfdM/LvN014tL05u/l8IcUQcr4xmzfqVfLTTYxLR5j2hxMf90/7MZEPWM2uSznmWVMn7+5uhEW9pWJlCbscxMvHzYNFENDJilSRMGjtgz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776877996; c=relaxed/simple;
	bh=52ACKqtJPNU8J7IzyA8jZwWgrUe0P6rodTQxUqKSM14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Of0Q5SLwA/gIqijjlsqG6DjAntsNt8EpafG8EsFUseWy80JHu5sI5awBWyPN6bF5a4waj33cCNnePETeJS00bYZX8gfjFHRYynDA4GlUsE2kasBoS6Yqs/xI2g/tCwHpvEQvNykQUTfNGsVlYHkSx15lTkUnfodvJc9bJnQb0iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35d99bae2ebso5217593a91.3
        for <linux-pci@vger.kernel.org>; Wed, 22 Apr 2026 10:13:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776877994; x=1777482794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7OLq8sGj5BrTnHpABdVqreRTaKZmGbdWyjjPj4eOAQ=;
        b=M6sfp75exEvNgbr3iMgTRN2THYiTLToY73hDUFboqTyY5cmYdvtiAdIvaVUHoi1hpl
         BynwROmBDoFuZ91ZWppBTYWs90uNuHqwFhko+bcmn1v1f2giaX2KijUnkvP5zruW5Wtv
         y9Sqd8zNDkXPg83lObWre+d1LILhVKEj/vy54FYZt2PmWXjr2hj806TvDTYktJYzJ8yR
         fqLQRxqmt6Tf2I5jSPdZZYOvEZP8DVTrXaSisAr0y5Y40JJiCuVVrWfQq4W2CxymDrh5
         JsCBiNI11McxKxqmk9dLIHWMm0vPsA0xVtbS53nsSdE2ZdqAUq2w8IP+MxX6nOtWww5Y
         rPJA==
X-Gm-Message-State: AOJu0YzH/+RydTembGEjT9vNdCeFThKI59jYKPvP30Bia4Tdnw39mEZz
	jC4DGlMY/8WBR95N6UtMDb2CIsHOk2PEXOiN/9jg6FKdwenj3tIWm2zV
X-Gm-Gg: AeBDiesnGFlW8QxzyD6feVgkM+69FhLYHCUrINFJyQKhJ6ICiHupHPsgNDQz1ubgGl7
	ovx3lZ7NOjSQY6C/YCz8/eg5hmo87eWE32hV+CPbAExo5QqytxdbPfCRDhW+p5hI64K91jKnJdT
	yuGqF0Y7gSeoFbLzKnzCRXmJQY37j4Qows5+ddghp9tXSVs0dRZ5LrzPw1AmGwIGTD05D9IvrVP
	kxzazwDH+gUlf+PHsq4gBA4Unbl+nemq+DMaFHwX3ngU9t4vd2YqrvCY8ej5GlrtfbqHqk95XW1
	rEDlMsh6l8E0QvmNdSuasGEPXeFa1aYc1P5WhWJsKs3iHAGk+/Ve8X63T+bUaNhiq8kJxFIj3B4
	YhLFvsaL8c95JErCZBXuAwxlcTdbDPoTrB70g4+iFPb3F28ZvGFXfgO3mOQfPPn0uvqMRbaA/95
	mSaPmr6V+Tno30OtC3E7cngva3RnckmBJOwy7uvmPofiAaF9PkV735Edj077KY3yHPoRWPl5uE5
	MSvc6c/1KYJh6SjutjQeooO43tAYl2NSpjCK4gsLqZ/3effMtc0uhRfI4TI2j8lDBmU7CaXDxMH
	sV+yaQqzgvFTiayLObhS52fxJ8aE+PXq/avKcVxSyQ==
X-Received: by 2002:a17:90b:5185:b0:35f:b7f5:9b3 with SMTP id 98e67ed59e1d1-361403b18c9mr24815197a91.3.1776877994335;
        Wed, 22 Apr 2026 10:13:14 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c797704b575sm13710354a12.29.2026.04.22.10.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 10:13:13 -0700 (PDT)
Date: Thu, 23 Apr 2026 02:13:12 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Ramesh Errabolu <ramesh@linux.ibm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] PCI/hotplug: Add 'uevent' sysfs attribute to
 trigger slot events
Message-ID: <20260422171312.GA410657@rocinante>
References: <20260416213909.705753-1-ramesh@linux.ibm.com>
 <20260416213909.705753-2-ramesh@linux.ibm.com>
 <20260421171334.GA1684602@rocinante>
 <305d85a8-660a-4063-9b47-5707d8b25fa2@linux.ibm.com>
 <20260422044450.GA2544787@rocinante>
 <742b8820-4bfe-40ef-85a9-5704af038ee1@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <742b8820-4bfe-40ef-85a9-5704af038ee1@linux.ibm.com>

Hello,

> > > > > +static struct pci_slot_attribute hotplug_slot_attr_uevent = {
> > > > > +	.attr = {.name = "uevent", .mode = S_IFREG | 0200},
> > > > > +	.show = NULL,
> > > > > +	.store = uevent_write_file
> > > > > +};
> > > > I think, you could use the __ATTR_WO() macro here.
> > > Use of the suggested macro is not appropriate
> > Just to expand on the "not appropriate" bit here.
> > 
> > Not wanting to change the name to have the _store suffix would be fine.
> > 
> > The __ATTR() would work here.  But, this file is old and wanting to
> > keep the style aligned with rest of it would be fine, too.
> > 
> > So, both of these reasons would be fine, to avoid using any new macro.
[...]
> 
> Hello Krzysztof, let me first apologize to you in the way I said it. I
> should have elaborated the reasoning the way you did. I am open to making
> the changing if anyone else feels it is a better way.

Oh, no worries.  No hard feelings. :)

I just wanted to add a little bit more details for posterity. 

Thank you!

	Krzysztof

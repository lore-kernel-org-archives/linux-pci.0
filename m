Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92009501298
	for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 18:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789668157; cv=pass; b=oZpGYEjLZe+wRfzThrzpBYKrX+9b0w/MRSkJH3E6CoS66wJWvb4mL8C/cVK+k4qwhSqXN+JTPYb90/9iGiOw1Rs9BwIuL6mPuzHzRKz8tEIQSlSQRXTKzPLaDGmml3ytpTasUD07WLnHcowbZxM0kd8S5y12+9uhAvWwqCzMviM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789668157; c=relaxed/simple;
	bh=Pgrlp+kanKdNoXJ+vKvKqsAcIb9YRQaef/KFSYsD/eY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UMWPO9ylHRIC9qNrCUA2j13u2gy3hhfMnRqMxzxvUU142aR0xN8/FUYYaTwKgjVdXJOtSplab+gADWsn6QZX/YLj4x1LEG5otYo0MDDUT5ZuLT7On15mDdj05XYJIdH6Sc4H0uXmwqhG4qLE0iSOy8tlvvwuEz6XSMpaMAAVOUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlFaUimK; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlFaUimK"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd88a115ebso10653415ad.2
        for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 11:02:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789668155; cv=none;
        d=google.com; s=arc-20260327;
        b=OGswbWM34NlJZTPudWX7vnqagtncIvGKwW9vLFWj4hjQ04Rv++FNUSBNmmnAdx7bMa
         cBHYhdZZdoRsM0JT3hMG5OXQ/owlDsPhDLFvtXvVJdQLW/0IuAbqlwcoUTBvPMQX85az
         jdLdOKWB0qerib1bJXuzXLR3IOTvVSjYOD+JRmO/aATanC+RQb3RVdblPPmXFHgpbpSA
         vHLptYwgtJFbaaPLCF3q0uSjXz3FuSwU16jI5EEcA1H+F0WA6kQNJxzFbPnWmQc2GD3o
         hEyZcTJnndtGbvrzR179FcHu+D4PuSRXj6BorruEIVcPtx/9fmlh+BmnLSa+L99PziHt
         ypBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Pgrlp+kanKdNoXJ+vKvKqsAcIb9YRQaef/KFSYsD/eY=;
        fh=CWuZHdsQEYUKm8xDKW293+zQQ3ic4D+7htmRmWlaHhc=;
        b=ZNi1f5pNnmVEEh+PHoRmlVWikXzBJ4vFtQ2mV5WRILfHmZckMNM+tVybHV6ph3LvIv
         M+fAr0T/YL4Ioi3Yqh2Gcz1bJRlPcb4rAq3GRDrE0vx7vLcYbPRm+8a7UibW58I0aNbH
         sMkY5CTS/8c9hqSrvr1bwD1ssKcxMIzbQn7/wDTD2flv9S4DI5Yy/0JyeJ3VUOcLsVGN
         yU2FkwrTq1rGVvulTx2vkdK8AKfz1W/6O2bjPsDCkj4uA35DlZZVnZairXtWRUb5aQGB
         OQQHQMBjg+FJRVB6/j5oOAy3hgsiLOTRruDwIMuWYRLO7aVa3F3ml5lNbYY8DNAdFir+
         9jGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789668155; x=1790272955; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Pgrlp+kanKdNoXJ+vKvKqsAcIb9YRQaef/KFSYsD/eY=;
        b=BlFaUimKgEMiwJjvnh+MIlGCw8cRY/xzAVpoJT/XjQemq4kvLFSuujj9G4trL9QpdZ
         zU9PnHetcCm9+7Wp5oSP41fQ/ZNP4AxGCZTKxjugPqQMrZ2KHM9B0A67VLotIhIa/p7R
         bjMdNF3/eAROzbNi+wbQL22aqhAXVqm2ErWodY0KM11WqjcCEXLCjw/AzTWRX0nlx5JR
         jqCrz9ocPDwzetP7g5/4kknPikr/+Iz7cwzd0ku/D6Zsv4LO4raSctzJKCCAnenWU0gO
         9SfCe7kr26AEOLyZ1PvU7UN8qNK77mxpqh4dU14ezbWsCewx2+z7Q/RHr5nIrFeKKEaO
         lezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789668155; x=1790272955;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pgrlp+kanKdNoXJ+vKvKqsAcIb9YRQaef/KFSYsD/eY=;
        b=DsOj6eqq1sFY0nscoXj7k5+6xDqq94RAg6onOvdiOl6IxFdvr31y910EI5jAOJtTTb
         EC2kdauXNrWrxYGhQ22WBHdCO0HOmRdgoMEqoXllKVSQBXc9x64ehYukEhqHJhko2ZVn
         WAmSB4YBgxkHPZ30UyifkTIhyye32VjmEV2fKygtkR4SJMqhm1pOcHakpTATYPlEO+AZ
         GGEMnJnStDQppySlba/hLKp9/Gtrf/ZeTrOfRrCFsjM4gDj9hs4wDz0hrR08uLunR3lG
         lZcP4ev1zvgCuIaYpIyQhMRzjBg6MEN9GsH7Lhcww+mIWQAjITgbwoUAzUkr6Ekk27pf
         xlgQ==
X-Forwarded-Encrypted: i=1; AKwUvBwb54aVsx0+O64M29J3NcknwPY0OsNpWYeIU6JKH45Ih4uKnKWCM6LRPcHHl6mPrNsJDFe7W6hmqnQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nuBWihUXSqWwG553G2fYCXW3Ac5oS4g2YUAbcuyjGsuA+xT8uQ
	4eCQgaCw3whbJGccHwMCEc5u2+kfll+Gyi6XQdodtXoIMOUs+hash9BkfCtoybXA96ICdhBqj5H
	Ey8rrf/LO5JQ03JeNZxyfKFGO7y9jv8E=
X-Gm-Gg: AYBFou1qKU+JV1sK1xo+WlLQArZEPWQgYp430m2/Z9+qMn8725RQPO7F/joKOoILQUq
	m8z9sDbfVmnPXoLOW8yDqh0A8N4+/ln6P3H1VNnby7mdY7OWAbDuPo2Ffve4WTxmtku4OUVK+5P
	FLIx7PHsnzBi01kM3IO6ujaQXhojc37JKwCCq+x6Cm/EPin4YNUZPio004xtwsSjfoFEVZMhnBs
	b3+CegA9zYyBCEZP92q+UfisQLAkzi5KQ+OWKfjNH2eQR8rSwvjHRM4r/3mGkiGneE8ynB6WuqR
	9Lhb3QOJLPnvZ+JGpc6082p2JvBM0Uus7XzxB3qs8fJ2oOESL1YkjuSyn0mJ1VJx3FJhi/EYb/4
	5YotYe/RdzE6alY1DrRT8B1q6IGYTrhBO120=
X-Received: by 2002:a17:903:2007:b0:2cf:afa5:b19a with SMTP id
 d9443c01a7336-2ddb1ae16a9mr141875ad.11.1789668154804; Thu, 17 Sep 2026
 11:02:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAsRjR=1iL+Nw0+0erVH2t8igpobXBfcqijz4vzMO7cW=ryHPw@mail.gmail.com>
 <20260917155929.GA1023894@bhelgaas>
In-Reply-To: <20260917155929.GA1023894@bhelgaas>
From: Semih Baskan <strst.gs@gmail.com>
Date: Thu, 17 Sep 2026 21:02:23 +0300
X-Gm-Features: AcwNN1WnIP6FLPzSZ9jqUd4tiuCtAEofHa6BPB6t-cxgjZWjftKahJr7LIWgfdk
Message-ID: <CAAsRjRmmPanAjpquZ4VnDDw9jqRkxPkLsu+KjrpwsOMj8-TE-Q@mail.gmail.com>
Subject: Re: [PATCH] PCI: iproc: Use pci_alloc_host_bridge() on BCMA
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	robh@kernel.org, bhelgaas@google.com, rjui@broadcom.com, 
	sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
	rafal@milecki.pl, zajec5@gmail.com, florian.fainelli@broadcom.com, 
	arnd@arndb.de, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	rosenp@gmail.com, rani.hod@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 10:59:29AM -0500, Bjorn Helgaas wrote:
> And why do we need pcie-iproc-platform, since pcie-iproc-bcma.c will
> claim them?

I do not see anything on Northstar that needs it. I think
pcie-iproc-platform is the front end for the iProc SoCs that have no
bcma bus.

> Is there a requirement that pcie-iproc-platform must be able to claim
> the PCI host bridge if CONFIG_PCIE_IPROC_BCMA is not enabled?

None that I can find. Neither symbol depends on the other, no in-tree
defconfig sets either one, and multi_v7_defconfig gets both from their
defaults. OpenWrt builds only the BCMA one. The one use of the
platform driver on Northstar I know of is Rafa=C5=82's: 767012397976 says
it was tested with it on BCM47094, and his test in the thread on the
axi ranges ran both drivers on his board. The platform driver
enumerated the two BCM4366 devices on its own:
https://lore.kernel.org/all/93ee7456-4179-4d78-b980-1df0b7e0278a@gmail.com/
I have not looked outside the tree.

Best regards,
Semih

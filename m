Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F1E3D8910
	for <linux-pci@vger.kernel.org>; Tue, 21 Apr 2026 15:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776784881; cv=none; b=Tjv3lvbgTKuCIJ7kVInorcJfxfVSgwKlRGnlp+O1OxBfVxiOihGid3yoblaQV6rBVOKGs89rvWuDq1Gy19QQwALU+iEzasfBz+Ytk8vkqKfSnbEOqlKq1/scAMc1npo2a3Nw3uVI3PNGDjjVXjguicg+y+pI3r9Bb28Yby1ej9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776784881; c=relaxed/simple;
	bh=Kyk3+wNQNdoAB6SWDPZsFu2inFstrAooXQvG3g3opEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rsc1a3ciRNEV5v9sFXsLj1v7g+dRCluXv8o/nUXFijXvSgQ7AWwjL9qiMr45qQM+x4RoGxxZAcn3wVgrHNc4zEB/uy+sgkGphaxVA6Uz3BUDpUgIlSJ9vc786ddYzsY3pd/nA5cxWrqBrih4HDNF71pzL9TqrYojx120IYAaHtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=PnE3rtHZ; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="PnE3rtHZ"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7a469383e0bso32727787b3.2
        for <linux-pci@vger.kernel.org>; Tue, 21 Apr 2026 08:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1776784878; x=1777389678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+B+8NSAggTlzgSEBNF7JVWtV7yl/tiBwRJ1+ICjPNI=;
        b=PnE3rtHZrkUDAAshE5K4db3xIHy0sqcovsfzAj/DRChCNXuPebUBoBNXfXqcjFhFm3
         HLTvCJdHlNG7yoZf0qNnBI7jPr0Ey/FmdTV+xnXQRVcgNJBqxdnu7hlV0pXQLq3+C8iK
         Cuo5zVZWuyxOcY9CNEw1egJrCY17MQlvieQgDjnPiYyo1ERorB91YVkBTDSSrgZV/f7g
         z5OciUO1IM7Y9fjnTqp9LJphwAELTieaqHjHkjjXHyPsiNt5y+RrDfnG2bVBbsdarZlq
         VnTeA3xbvVX8Ub388Z2BKLpI1CBGYMiPeIz9Yycv49hD3fOsQooCy4HIZ6f9jDynE3f6
         qjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776784878; x=1777389678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+B+8NSAggTlzgSEBNF7JVWtV7yl/tiBwRJ1+ICjPNI=;
        b=mn5Um8sdipK6d7MqVLn1z1KFexKAOVzNTz1eP+2QqMjlb5ieJXl8yFD4da9Jlk0q1q
         +3njoOniJS+HjTj8Szz8Qf0RznVVOG30ZdQSFa1tOjfok3Rns1YTZK0MEIoTv/iHxZFH
         Kg7hsn71rpXHAfSmYVi6JKPn0dyr5lriQAzjexjYn1Tlab/ovHPAGaZYuBmBwp/Cn1c+
         qSkMK1Qz3ByM7Zq52UwHe+H9K3elsz3BvJwV3YJwrb0c+zJH6DqKn511/aj7OcII9nDJ
         wjOdMDU23aEebiaErTagr34Ar/vD1tHujuv6sNuEP/SeQJP54CIzHwztWJeizlg6OrML
         H3zQ==
X-Forwarded-Encrypted: i=1; AFNElJ80W3mLLocZzC7L2gTPweSEKKRVcuJ0BGPXYMkSBKSfkO8w8hS4e+79Tc57x3DgkyOdTfyzdJn0gb0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3m99p4jpjge0PHeyTsqmMd8dxKGXXB9sTwWDZn3mVqrNIoAQb
	3Jq1vPbJU4IIVyRO8+HldkcEEkIO2299VpTTLZgxIHnppuAvF36x4H1xoPMfbAr3Hwo=
X-Gm-Gg: AeBDiev9Z9BvB9IFnVMw8f7gWk2dhLs8ZaufCtlkamXBW5sBk/MGJhghTAMIm5wkd+e
	Hicu3dt1sGMz4v3pN4KgVves6DN0I3vi4pp7Z2GJMnC9ThZP1b90t/B9L8DnjGHtMU/GZW1e7kj
	exT3wgF5dsFm1eLWTdqPc2wQhcxswWQ8T+GVOaMV/cVQapp231ZrObNdaKidL1NSrBuZ35lFQRL
	5m+IdbUTG4vBoS4q+fu+nrf30QBfCYHL12ZWMWG3RSWoRly5URQy1ALUEuBh8WZrc6nA/L8MwTV
	vlNPXjw5jLtr45FdCNPYlRN0veRxg6WqqrEk5arpfUWJRYBR41gC8aOdZ+srqBrU29f9zCnoWrk
	+478J54+HhYqzp8oV8blFWn8VUG/L03jsHJ/Mrz6CiRH5zRIt1JBJ0KbhKFvghSKnG6yLEkxQF1
	Uqh73mjE2MrO3qEcElTp8R23Sup3fPC32xt52S7XIdpQDLli/NSbSxQynEe66MCu7lhkB0JHryW
	NC3i8Es8KkmomaOdimUx1/osQkkcFVp6sgugFYV
X-Received: by 2002:a05:690c:f14:b0:7ba:f677:8c32 with SMTP id 00721157ae682-7baf67794c3mr66413557b3.15.1776784877840;
        Tue, 21 Apr 2026 08:21:17 -0700 (PDT)
Received: from google.com (57.233.150.34.bc.googleusercontent.com. [34.150.233.57])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee9b293fsm56526037b3.40.2026.04.21.08.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 08:21:17 -0700 (PDT)
Date: Tue, 21 Apr 2026 11:21:15 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Jeffery <djeffery@redhat.com>
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Tarun Sahu <tarunsahu@google.com>, 
	Pasha Tatashin <tatashin@google.com>, =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>, 
	Jordan Richards <jordanrichards@google.com>, Ewan Milne <emilne@redhat.com>, 
	John Meneghini <jmeneghi@redhat.com>, "Lombardi, Maurizio" <mlombard@redhat.com>, 
	Stuart Hayes <stuart.w.hayes@gmail.com>, Laurence Oberman <loberman@redhat.com>, 
	Bart Van Assche <bvanassche@acm.org>, Bjorn Helgaas <helgaas@kernel.org>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH 5/5] scsi: Enable async shutdown support
Message-ID: <aeeV1e4j4ok9_iQz@google.com>
References: <20260420152608.6244-1-djeffery@redhat.com>
 <20260420152608.6244-6-djeffery@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420152608.6244-6-djeffery@redhat.com>

On 04-20 11:26, David Jeffery wrote:
> Like scsi's async suspend support, allow scsi devices to be shut down
> asynchronously to reduce system shutdown time.
> 
> Signed-off-by: David Jeffery <djeffery@redhat.com>
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> Tested-by: Laurence Oberman <loberman@redhat.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com> 

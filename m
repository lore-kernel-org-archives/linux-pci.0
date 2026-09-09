Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0917449E5D2
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 09:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944793; cv=none; b=apzGLkrAjKB9tE68cMB6xxxMw1VG+s6/fkyij4nsRBHXodopi6h+Nxojz1S5yq/kPaGogIURT/DHvPPS3ROCZZotN9ZzLIsH7uS4ZCeIgvAHUpXUY15L2RF1mP5hV8C58fZcF567Y58q4R/Pw7Hd3SxN1zUIjgCdkllJHxMq5RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944793; c=relaxed/simple;
	bh=MDBBmeOGt1jJA2QyqYyZpKdJgVhokM9Hyvk+N6kJG7Y=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pW9YKB0zAtQNKrSV9JQdMFRDQsBRyUr6eNP5R/jYxGpoE3u7AkS6DsaYycGbnYPEgsAI4ZwXfRwBfXbwppddgvh1ly+9d0alYN3rdAlOSZaU/rgJJjTP80McrvNcmJVDsajpkRxz57GYiryeTJpxRQbLqAFsteGplcq3Z5FUT8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1Dgu4B2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1Dgu4B2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA70E1F0155B
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 09:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788944791;
	bh=osuKNlWwkgDC1U1icT/Qoh45Es9k9O509Xjy31GoFe8=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=m1Dgu4B2XCYkK9uqtTe9U9zEXs0+QrbFPh/q2c/n8LAZhnNC57aXu7oDMWH25YFrp
	 9M2uoKoGR0DUSNTkL3g/H7OsUoXwQwe3tockNtuif2v6KCgmiZhBLiZfpFCiHmtePp
	 Ba0GX/O8QSZZ2e1PFYofcm1ZihQj+A4SwJ0IR1I9Z6n3NuDtUxi+qnbBBYRVakRThB
	 YXRpuC/R0xLvXvgN8OC5C5P2hHsyLiPrcv/x3z8mk/Adi17+SZdQwgIpCpfpwHlzP0
	 TZTIQSliDRZSrY2WY7ooZWDbOWX076STbMR2HTqAlqJCusNUgpsOdOCmSq9L96ms35
	 SuQ/zVSZCkVoQ==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3a151eda82dso47232521fa.1
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 02:06:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx0Gj+mgCfhZ9CKruBiuoYulZKcSNOy8gCi0NlqGYzgeQPFKzqSCCxLuvLbkWqDtIUPEQO6ECORoWQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lFiduFT0brU2gMOodlSlLX360ldxT4omGCp8U2tXp4o1R7zR7r
	B/K/jHVUIzRgzfQePKx/8+bQNryC88YIne4jUiS2fJBXaFwN9ccvlLGKcYYgc5Gj/aPPIIOwGZQ
	CGyCSaTEm24PNizCGZbUb8uQ9+mGOk67t87RGh65u9Q==
X-Received: by 2002:a2e:bc13:0:b0:39c:624d:82b9 with SMTP id
 38308e7fff4ca-3a371b5785bmr81319681fa.4.1788944790433; Wed, 09 Sep 2026
 02:06:30 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 02:06:29 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 02:06:29 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260909080114.591938-6-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909080114.591938-1-herve.codina@bootlin.com> <20260909080114.591938-6-herve.codina@bootlin.com>
Date: Wed, 9 Sep 2026 02:06:29 -0700
X-Gmail-Original-Message-ID: <CAMRc=MfMvXWLHMb1w7km_JCsZvE9_HmhiAWgoMi9mjxXL3_8EQ@mail.gmail.com>
X-Gm-Features: AcwNN1UAL1h56FAgIlDt7ND-Ag45pHEciGYFt6Y1QX_NiTCc2meGcA2HgU6LiJg
Message-ID: <CAMRc=MfMvXWLHMb1w7km_JCsZvE9_HmhiAWgoMi9mjxXL3_8EQ@mail.gmail.com>
Subject: Re: [PATCH v11 05/10] cxl/test: Use fw_devlink_set_device()
To: Herve Codina <herve.codina@bootlin.com>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org, 
	Allan Nielsen <allan.nielsen@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Daniel Machon <daniel.machon@microchip.com>, Steen Hegelund <steen.hegelund@microchip.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Richard Cheng <icheng@nvidia.com>, 
	Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, 
	Linus Walleij <linusw@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Len Brown <lenb@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, 
	Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Lizhi Hou <lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Sep 2026 10:01:04 +0200, Herve Codina <herve.codina@bootlin.com> said:
> The code set directly fwnode.dev field.
>
> Use the dedicated fw_devlink_set_device() helper to perform this
> operation.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Richard Cheng <icheng@nvidia.com>
> ---
>  tools/testing/cxl/test/cxl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 547ebc97bf59..e21e45fe1572 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -1678,7 +1678,7 @@ static void mock_companion(struct acpi_device *adev, struct device *dev)
>  	device_initialize(&adev->dev);
>  	fwnode_init(&adev->fwnode, NULL);
>  	device_set_node(dev, &adev->fwnode);
> -	adev->fwnode.dev = dev;
> +	fw_devlink_set_device(&adev->fwnode, dev);
>  }
>
>  #ifndef SZ_64G
> --
> 2.55.0
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

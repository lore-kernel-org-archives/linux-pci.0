Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029D74CC27C
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 11:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953262; cv=none; b=kZdGn3ir30xB0h/7BrfatBJIsnRMdbDU6S/0G1Yj9dfLzrH4uzREEJUtyWzUwzCGH8BhDOT3Krw+wgZ9wP1BNtFmiUJf/FlkfEtzjgsnTebQiXIZ+KxRJ0+hJC18CQPM/ix8w+GpxJfIVid6RCT1V9dF2l/rgcmkGKotULFKFPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953262; c=relaxed/simple;
	bh=MDBBmeOGt1jJA2QyqYyZpKdJgVhokM9Hyvk+N6kJG7Y=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SDeY2wOEgHORZz9KEHKvk5vRWfPgJr2LAWDf5ivVdRYn2c845CmZbVk9LrU6JtTYx42umqjjpnQisuH++2Qj6uP+rmy1VHiRCPXnv/ANNAkzYTsNIHctpfLGvQPRiRJsr5vf3UjaVsO3UnDdDabXVZuuIeS2zQkKWKWJS9MSckc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/5oxAk6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/5oxAk6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFBF01F00ADB
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 11:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788953260;
	bh=osuKNlWwkgDC1U1icT/Qoh45Es9k9O509Xjy31GoFe8=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=g/5oxAk6rFs9X8uCuS8aKIxpQhjg+Afx5XxH08fGGI+xuKmzaPE/BW/tDbqXh0xNz
	 sW2k8acJ1ScZuyS7HWFkoQZ1OVJNQLpegosiENm5x+ERvxwcgFXqQz0rmp+BDQMQrV
	 rhkNjmzEf0P1fDlv0E+IsLEWZRasu+TjRlsk8FJBsaSwhERUqtspV+aAAIFcytZ9QX
	 RzmWriL9yTUDBmLUeqvhlruCA78o1uAJcEOSHlOpBrn0/nr9Y/TwWszZYrpayGl6Yf
	 q3Ub1vtMDNSZLSsd4WVQm+0Q55Xwqe23CBmRpE6tKGzFOubBHTTisOS24FSPijXPoQ
	 WXc/i/dD3EEvg==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b754cc3b6aso3110817e87.2
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 04:27:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxUlLwRGclwnWr1oqyuIyZzIY1rTICYckLJ0r6PxXIThy++m8GYDWt8ZAO7bIcgV/d+aVr1IeTSY84=@vger.kernel.org
X-Gm-Message-State: AFuF++n+wE5cdzjesI06EgLl0v7SUftnR6v2ytZNV+BQhQNvyzyfU1FI
	Ez+ASz8lKnxFpYt+rX4ynKAUWFtXqagog0kRQa8nez0fidJyt2hnrav1TYvZIGoUW3Y8g/VbJhF
	OPH0z8jeUcf3MvkCrIFebzLnPdUJ/AOHbmuuGMTHwiw==
X-Received: by 2002:a05:6512:234a:b0:5b6:1a7c:aa0d with SMTP id
 2adb3069b0e04-5b61a7cac20mr5414087e87.37.1788953259475; Wed, 09 Sep 2026
 04:27:39 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 04:27:38 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 04:27:37 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260909080114.591938-6-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909080114.591938-1-herve.codina@bootlin.com> <20260909080114.591938-6-herve.codina@bootlin.com>
Date: Wed, 9 Sep 2026 04:27:37 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mf8Hp1k+s0A3+T0XCWbm0mzV3rGDOd0=gkM0x+arqf2fw@mail.gmail.com>
X-Gm-Features: AcwNN1UF2eAGvBL-3uNx_wKL96_0i716IzDQOeLpWlE0LgzqTry7SnN7eIT7jms
Message-ID: <CAMRc=Mf8Hp1k+s0A3+T0XCWbm0mzV3rGDOd0=gkM0x+arqf2fw@mail.gmail.com>
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

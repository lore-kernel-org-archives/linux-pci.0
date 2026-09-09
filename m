Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA5F5476D3
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 11:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953499; cv=none; b=RkptsikKlWfk2whdu+C1ae3wd/XYnggBLIaaIjCpbEDcJJAg3nrojw0DRG+iRogTSHeZmTmo3tCqA8/Bt7GW6Q88hTEa+JjTbpQJWxQzf9ZnpyuhO0FcT6NAYz8lpo0Diyjb9macYjzf+v/2P4osxvCzSAh6nGLAYf6/p10Y900=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953499; c=relaxed/simple;
	bh=gXMJw/DQ+kIBXhLqPTjgG8GcAowRylo+yXDoPCBkgwQ=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IwWA1SOs7+Etr8VZKdSklMUBxUqsvVs+Gzy54Kvz5bf6LXEckfM7QGWGwQQALElFbst2RLl3RebpGOFzLjbq/e6oB3XaQSYN1yhVgbqtf9KA1UJOUHslfjnyeMT0epvu0qwlVrSFs4A2++NZhX24lBhVTSBS36htqoAT8wwuIQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lgu9UQTY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lgu9UQTY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3BC1F0156C
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 11:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788953497;
	bh=4HrDWZ38uz9eK5QO7WA7e1rSHfMfcm4h44xrKZFOY9c=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=Lgu9UQTYB/wumaHz1xnypB7xjEMGRnX170oyZY53mDQpAI9jPWTsPtVtaIqAnqhsP
	 Bli5+2apr/kL/Tix4LYZai5TDPa+r3/TL8/GwSuTLgEmpNTvj7I34+U8CY8gLHqeTN
	 lHaYcanqPMrbT5wP4ndecxV47W8K6q5xIiD8jLoUXw6VcnvZYHu9Y1MTSn/xAN9hgh
	 ZCNQFEtcTCKuZzLjTrUeosovfUnFgXbjs5wc1Vv6P2aaA4GZMRL9H/BtN4svte4TMD
	 78B1XJoFLxdimyNOLkncz+vGlVIzml9fhQN1lR3uNrm2U3a4tUug0l9QvRv0uaHQHl
	 /FN45hgL1Vqww==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3a33307ecd9so61838161fa.2
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 04:31:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxb593mrX+9uzhgg1TJJ19QkuJ6KMi2ff6I+OmsIVk58yv5RjzMutaIw8XjsYHQEHQNN8whiy2Qs6A=@vger.kernel.org
X-Gm-Message-State: AFuF++mXefPVaaBns9PfFPYN7kLUnD6/Ixm7Fe1LHeDvT1k0kmHzsLb9
	k2WoY5WlGl1eCGZGmHT+4v6flyTJE8dAPatltiGL7wm2rJDshlBoTqTjpFMRDgI7izZNAf1rSEm
	T/ERBiAQYxaH2Lc6ULLVHn3u40o71OtqNZRtuF12qgQ==
X-Received: by 2002:a05:651c:3049:b0:3a3:a3:3560 with SMTP id
 38308e7fff4ca-3a371b2e558mr39827311fa.6.1788953495876; Wed, 09 Sep 2026
 04:31:35 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 04:31:33 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 04:31:33 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260909080114.591938-2-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909080114.591938-1-herve.codina@bootlin.com> <20260909080114.591938-2-herve.codina@bootlin.com>
Date: Wed, 9 Sep 2026 04:31:33 -0700
X-Gmail-Original-Message-ID: <CAMRc=McjcRnO5PWPNqR0387dRHyBU0057LmbKyVstq5m1ghspw@mail.gmail.com>
X-Gm-Features: AcwNN1Xw1KvJ4chWgNCRGrWjb7O5pyZPCvmfkUuZ4FsL0lp5LvW4mH7OpBMH6KI
Message-ID: <CAMRc=McjcRnO5PWPNqR0387dRHyBU0057LmbKyVstq5m1ghspw@mail.gmail.com>
Subject: Re: [PATCH v11 01/10] driver core: fw_devlink: Introduce fw_devlink_set_device()
To: Herve Codina <herve.codina@bootlin.com>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org, 
	Allan Nielsen <allan.nielsen@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Daniel Machon <daniel.machon@microchip.com>, Steen Hegelund <steen.hegelund@microchip.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	stable@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, 
	Richard Cheng <icheng@nvidia.com>, Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
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

On Wed, 9 Sep 2026 10:01:00 +0200, Herve Codina <herve.codina@bootlin.com> said:
> Setting fwnode->dev is specific to fw_devlink.
>
> In order to avoid having a direct 'fwnode->dev = dev;' in several
> place in the kernel, introduce fw_devlink_set_device() helper to perform
> this operation.
>
> Having this helper allows to hide the fwnode devlink related stuff
> behind the helper.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> Reviewed-by: Richard Cheng <icheng@nvidia.com>
> ---
> Cc stable because used by other patches with Fixes + Cc stable
> ---
>  include/linux/fwnode.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index a9dcaf7e7076..3ce49575cf82 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -260,4 +260,10 @@ void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode);
>  void fw_devlink_refresh_fwnode(struct fwnode_handle *fwnode);
>  bool fw_devlink_is_strict(void);
>
> +static inline void fw_devlink_set_device(struct fwnode_handle *fwnode,
> +					 struct device *dev)
> +{
> +	fwnode->dev = dev;
> +}
> +
>  #endif
> --
> 2.55.0
>
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

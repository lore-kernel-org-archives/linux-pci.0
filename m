Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0413648E0D4
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 09:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944784; cv=none; b=Ewv1PxUvqe0T3gP4C1AeKPoBoiLDHFRfdqDEUR7lYPPTT1IOyzic7Tqw5XlTNyt5GHgRYM+aPfmadd7svVJ+I1n8+uxg88mYYEGxKLelw5XTjOz5cKCecL8iM9OGoZCM4TJ9eI2pESX4YfbxxdlB5/yc+I30NYPuaU3hSB4liTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944784; c=relaxed/simple;
	bh=kjC7zFmvS6+Z0Su5AyND9tbS4+QZuh6pAhX8y/gfjkk=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mi6pnWSSsLO8qmcQdmzd/5CoYwk5i2y+qovG6gXozv2Pg6NCorT9kNKXhdNqioTNEQSrT/s6XuULRUcFErWEmHSgtbsNu2eVISlShBvAv9s/bj5Pg8kXLju5egz65vqAMf+5IGS8LjH9AkZw5zAtO05KQlHfLseY3nS9RkY/Qsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXm2dDTq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXm2dDTq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB5B1F00ACF
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 09:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788944781;
	bh=dii2jE7C72W2ski5o7RHBY8kSMlzb7654UkI7tfR0PE=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=QXm2dDTqlawpzUKdH2+SNJMCzqg70ZPHzpXImpE35OqvKbcWRXUTLibBkb+G4xDlz
	 dzLJsh7eoIz1A2jwF3kWkyb/N3kPfQReyR3aR/MnFAGQGgpQl90VcITXo82+oLzKEU
	 Kz+5jY9YNszGfKfeK0XkcOEXOZVtNEReOZPdQHmyzHBt0zbBGJQBOjpydNXmgo+sA2
	 It8cpdRykkukGN/OvO4uMKqDs4gWwJNm4hZtmNR6z4gI1N0u3SZmE0JLfSXbrUtgI6
	 f+cwqkR1SQ1sES5sZPGZQe6m9pz/Q8RKnHyf1oxkzyWtcxgrpNE7h31Aao313JlkWz
	 EMiSTFZznYieQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b523efb0bfso4258496e87.3
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 02:06:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxaQdraA0UaVFpOnb9rokpy2Y3msE00ESelYhWEWmvQBMlPY4SRpF7HGqG9CTXXIW5FQ2Bt3N7Efqw=@vger.kernel.org
X-Gm-Message-State: AFuF++n1QRzGDgiDDJ5zwqPzRjcjhh+lpXDFEgmDPb6DF8LeHQYP+upB
	DqTCTydC14kz93/QiAnUle2oTFlowxcKa7ChthpUElr/nb1Duj/J6QJ12/DmqbWyJzpJjWBSjoZ
	HbtHoE2XKr7efB0j9/qvWXA2pUAbZO+DFjwSJc2RljA==
X-Received: by 2002:a05:6512:2392:b0:5b6:19e9:faee with SMTP id
 2adb3069b0e04-5b619e9feadmr9372101e87.7.1788944780379; Wed, 09 Sep 2026
 02:06:20 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 02:06:18 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 02:06:18 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260909080114.591938-5-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909080114.591938-1-herve.codina@bootlin.com> <20260909080114.591938-5-herve.codina@bootlin.com>
Date: Wed, 9 Sep 2026 02:06:18 -0700
X-Gmail-Original-Message-ID: <CAMRc=MfqMBixhXHVmYhdpGc6BU7M+rrs8EQ_j+q3hbotkqCjEw@mail.gmail.com>
X-Gm-Features: AcwNN1XGS28aCCiZZDD6zMMd556ezTre_MtLVw34sLu2zEhsTocTiN_vEfjyNZM
Message-ID: <CAMRc=MfqMBixhXHVmYhdpGc6BU7M+rrs8EQ_j+q3hbotkqCjEw@mail.gmail.com>
Subject: Re: [PATCH v11 04/10] cxl/test: Use device_set_node()
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

On Wed, 9 Sep 2026 10:01:03 +0200, Herve Codina <herve.codina@bootlin.com> said:
> The code set directly dev->fwnode.
>
> Use the dedicated helper to perform this operation.
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
> index 62bd92b3be45..547ebc97bf59 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -1677,7 +1677,7 @@ static void mock_companion(struct acpi_device *adev, struct device *dev)
>  {
>  	device_initialize(&adev->dev);
>  	fwnode_init(&adev->fwnode, NULL);
> -	dev->fwnode = &adev->fwnode;
> +	device_set_node(dev, &adev->fwnode);
>  	adev->fwnode.dev = dev;
>  }
>
> --
> 2.55.0
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299F83AC0DB;
	Mon, 23 Mar 2026 13:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774273483; cv=none; b=VeQphJrtdagkL5kJybPM1uSmRycZCZLvqxj7EkQv4PG96SMB5LQa5cB8nwcLN6wqk4L1wHN5u9rZFatRQC004vHIY2UH7VV7cAD5GL96Vb38XxtqIEk+8e0lsah4bCF7E9UmdMSJyZBbbgmyfASB8a0Amqach4JRPBmcaceKYxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774273483; c=relaxed/simple;
	bh=dM3usFa/CH2CQNlckUtJYg1/lc5x13uRDhL6UhisUYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rb5Tl0ALAXfak5oCfOxm/GpiS1vKFXjk57Zs9bkSdgcQdeuu+2RsKF8lJyookB574mjWzQNe/z6F0MpnOoaehcvIZy4Cn/rwrF8nyBg+rusQULuZdJ+WJQn3BbuGTxeblSpov1+wuK81HNBG8ECXFAorbWaHpooZuqAbZWWq5rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WM3pG07h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WM3pG07h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CEC6C4CEF7;
	Mon, 23 Mar 2026 13:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774273482;
	bh=dM3usFa/CH2CQNlckUtJYg1/lc5x13uRDhL6UhisUYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WM3pG07hca8d9xLQPE6Z2Ay5mKGUZRaYf3cCe9eZSGFQWlyulVdxvEQCCW00mdtJ9
	 HKXzKqExCdiBbsV8nUVvCWvPzjGmqec/K5qpD3/a69htrnW8AE6D04jbhUN94+6HkY
	 vrNdcZRyI3fRJGtDYGb4nQ1VJMzfDwHxokFZgPhcuB4OjTJiNvFXOxptBs3mNtUL0N
	 /lHXcL7UA9GN5Puq4FiutMZ3oAtyZB4qRYhug8KoiciYeJvfasRLvnGdU3VMQrKWyW
	 y4/JLu51QAbH88sXdb/gdLHhB2xRFUPtQaySgFgCnhQw0hJOMzjOg0h5xQMVhGP2+j
	 gMPQ14O7+v7Nw==
Date: Mon, 23 Mar 2026 19:14:25 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v6 6/9] dt-bindings: connector: m2: Add M.2 1620 LGA
 soldered down connector
Message-ID: <6aef3xxjjd4nbgrfx6jc6jt6rpqmttoui6hil5zqgdpas2j6gj@ie6j72orenou>
References: <20260317-pci-m2-e-v6-0-9c898f108d3d@oss.qualcomm.com>
 <20260317-pci-m2-e-v6-6-9c898f108d3d@oss.qualcomm.com>
 <20260322233713.GA98177-robh@kernel.org>
 <to2mrizprc3hjufqbiplpqyek7f4uutqtn4hx4gkmdgv2rykbc@ybwwjhdec4nm>
 <CAL_JsqJXrHCJt770bJkMmAUhirSF3kHjYwSzkG7cXp7-eys8Rg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqJXrHCJt770bJkMmAUhirSF3kHjYwSzkG7cXp7-eys8Rg@mail.gmail.com>

On Mon, Mar 23, 2026 at 08:39:55AM -0500, Rob Herring wrote:
> On Mon, Mar 23, 2026 at 7:16 AM Manivannan Sadhasivam <mani@kernel.org> wrote:
> >
> > On Sun, Mar 22, 2026 at 06:37:13PM -0500, Rob Herring wrote:
> > > On Tue, Mar 17, 2026 at 09:59:56AM +0530, Manivannan Sadhasivam wrote:
> > > > Lenovo Thinkpad T14s is found to have a soldered down version of M.2 1620
> > > > LGA connector. Though, there is no 1620 LGA form factor defined in the M.2
> > > > spec, it looks very similar to the M.2 Key E connector. So add the
> > > > "pcie-m2-1620-lga-connector" compatible with "pcie-m2-e-connector" fallback
> > > > to reuse the Key E binding.
> > >
> > > What is LGA?
> > >
> >
> > Land Grid Array
> >
> > > If not in the spec, is it really something generic?
> > >
> >
> > Good question. Yes and No! LGA is not something that Lenovo only uses. Other
> > vendors may also use this form factor. PCIe connectors are full of innovation as
> > the spec gives room for hardware designers to be as innovative as possible to
> > save the BOM cost.
> 
> innovation == incompatible changes
> 

Yes, I was trying to sound nice :)

> > This is why I do not want to make it Lenovo specific. But if you prefer that, I
> > can name it as "lenovo,pcie-m2-1620-lga-connector".
> 
> Depends if you think that s/w needs to know the differences. Hard to
> say with a sample size of 1.
> 

Sure. Will add the 'lenovo' prefix then.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

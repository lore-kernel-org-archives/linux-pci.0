Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0F0423A9F
	for <linux-pci@vger.kernel.org>; Tue, 31 Mar 2026 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974608; cv=none; b=UF93rCP6IEFF8Fgw+482PX8sZlSHvoJ/2nCAtzdICWEKKJLyo7juPZUi1x+cL4UBzotOf6YE0FD6hRSXeEqITbmKEkkslLraPDlaYyZTQAgsEOPT58dfi0flE/r5N2UVyk4MRdsF2LlkSGVE+XxurSZwHDybg+Fh8nZ95zHbbRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974608; c=relaxed/simple;
	bh=gRS3YG1pr3ibnZKjf/71FJl6wBB9Cgbl3KE/lAnEraw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ik2BErURSdl/+wZGxY7QzISFU2NJQOmuN8B0aqpz/e5zxRko7yfyrzqT2TWxSk+eNEu0+HesRotv1zZqFE/mdkkOhH5NqKVAKCucFsti4ImtPk4cL+DKzqdZCfps4gz0DYraBBeXj9VAWtZoooODU4T6G3pG2mxReVX0e4wsACw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dTSD6t0c; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dTSD6t0c"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43d02a71526so1197316f8f.3
        for <linux-pci@vger.kernel.org>; Tue, 31 Mar 2026 09:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774974605; x=1775579405; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=05T17Gt7zJJTuhvPKMku3wBY947ddWSwqLLasltmOi4=;
        b=dTSD6t0cNjOU5XQfbf0Gvdqi67J2ZS6/QRo4sGkOy57+ZGgiEuSmbS04k95w9AIL4U
         9Ec1WbJSiYysFd7vBlIhZi+fFlm/p/kz7MThVLDSsJ9MdpSvcxlPCav9WCnrN+UVX6LX
         gF+BysODJ7zsZ5HKLpOGEAnvPqc09UbSDvV3u/+9Bg/HBx1LKLZvoUKmADuwCSa0oydp
         9J3BHroLTiXBm1+jV9K1opvczZjSnAfbC98+MjA3ayziorkbXV6KO/0EKWsylayrbkwE
         VZxTW84SoVCgM/K6QZBta7bdXtm51nx/nltSglAtdqk6iwBv1YxhFris4Y8x6ohuZvcp
         NRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774974605; x=1775579405;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=05T17Gt7zJJTuhvPKMku3wBY947ddWSwqLLasltmOi4=;
        b=h4bBI6D88Ms7R+/VfXzY5KMz4WY+aDW76LyDqHnB5Gv7/hu2Xrl+rmfNrO8ELs1L4E
         d0rDudIHnzpTGnxc6Dk+UHO4a3LfJDfOKMGto3TaYmsuyw/5WLXTro0hbqClyDjkbWMS
         Av8Gt0tmcnhuiVimeqH/2iyd6hS/fMSdZmH6xVQqYMuXx0UF/skllEZRGeuou9Gwppw1
         MWd/ZzqDahhovb+HHk2oqKxZ2YRy3tBURNawht3mGPpe8WQG1WgDtYs+B5x2HdmlFEnH
         msUx/lidXK9PC8wlS4Fksedd9zHLhQdoIc6eNphMna3iaRiCc/K6h88SbBUSN0RWlII3
         nosA==
X-Forwarded-Encrypted: i=1; AJvYcCWThDeVfRAv6F45XyX4Hiv1sHV9jVQT6fIXMTeL57I89hanjAfH9MWHZhj9GEhg8fTcUG7k8MUf2JU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPlO4TsMSXqy+DINZMDj6vhFdzVMjnW9qsMbiGjAGHYjpY0VHJ
	B5+si6qeaGOOYTdx7PK33xTqe4LrVh0K53HOtdnW2ig20vJMN5iFPb980WJvF8cL5AQ=
X-Gm-Gg: ATEYQzwEpHp6/+YDWaRGP8elQ7vza0TjzcK6HIZtYzinnk47HM9R0BkQwVK6SErx/UB
	i43nUi88J4upmw0p599ZYVowRQenswlymWfRKEpafzkkhdX0X9WtoiXTchXpnKLfB8kFN9CrFeZ
	EZpXLdNgCyTyz+PWfXkJ4LTt1Tm36QKat6Q30sHTbgLeO4wbFahkAtW+PqN1D1PZh9RpANBpOv3
	f7cOeoKgUQfNDCTcCH1Nn3ci4nai+vV3B3MVtArtykTNg3HbdhYu35p50CX0COZp/1xrgd//XF6
	NjYBYPclWDhCy8oVRkvBJ9fT7ju4zcq8/lm0kDww4dhsOfOMwnvGIBiSRXMQIpGhM3e+DLVmFZv
	NwPpUtxvDJzJ3L0o+B8A9+hY1LWhp31Yd1eT6m+8hAfTaVrBCq0AVr7fptfQiN9smb80U8EM4nN
	8WWlG+9q1pW3HhAG3IJ5j3w4QmCSrelA==
X-Received: by 2002:a5d:5f53:0:b0:43c:f66e:f31 with SMTP id ffacd0b85a97d-43d150ddb4bmr483415f8f.27.1774974604559;
        Tue, 31 Mar 2026 09:30:04 -0700 (PDT)
Received: from linaro.org ([92.206.122.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21e9e24sm27279076f8f.10.2026.03.31.09.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 09:30:03 -0700 (PDT)
Date: Tue, 31 Mar 2026 18:29:51 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Rob Herring <robh@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-pm@vger.kernel.org,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v6 6/9] dt-bindings: connector: m2: Add M.2 1620 LGA
 soldered down connector
Message-ID: <acv2f1qbqu4PlSL1@linaro.org>
References: <20260322233713.GA98177-robh@kernel.org>
 <to2mrizprc3hjufqbiplpqyek7f4uutqtn4hx4gkmdgv2rykbc@ybwwjhdec4nm>
 <CAL_JsqJXrHCJt770bJkMmAUhirSF3kHjYwSzkG7cXp7-eys8Rg@mail.gmail.com>
 <6aef3xxjjd4nbgrfx6jc6jt6rpqmttoui6hil5zqgdpas2j6gj@ie6j72orenou>
 <fsvmmgoe5wslmxebhrrwmdg2ldcmhzvj53gjkdfnfg2m2rz2lw@dcfboaakz7ae>
 <bguhzabwryayyqkv4ilzwr3ixwv6bzxncblo3ircz2wm3fs52k@66zvcrfcb4oe>
 <blhm4csjyw6r667cleljgzd6rpwagttjo5rau7wjrlnjakq2qm@ekyhc4jvwmwf>
 <m44mupdmg7kgco62n4evcviagqo7wwgyt3gybugbxwesd4ekjz@o24r6v4tpezc>
 <3faffec9-dc9d-4eec-a652-a84d30d85c96@app.fastmail.com>
 <cvqdbqnzjmzoowxkvz2lyv4avropu5jw7h2r6zng3ecf245hgg@fsysjqflqd35>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cvqdbqnzjmzoowxkvz2lyv4avropu5jw7h2r6zng3ecf245hgg@fsysjqflqd35>

On Wed, Mar 25, 2026 at 05:36:08PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Mar 23, 2026 at 01:23:07PM -0400, Mark Pearson wrote:
> > On Mon, Mar 23, 2026, at 12:52 PM, Manivannan Sadhasivam wrote:
> > > On Mon, Mar 23, 2026 at 06:45:15PM +0200, Dmitry Baryshkov wrote:
> > >> On Mon, Mar 23, 2026 at 09:26:04PM +0530, Manivannan Sadhasivam wrote:
> > >> > On Mon, Mar 23, 2026 at 05:14:30PM +0200, Dmitry Baryshkov wrote:
> > >> > > On Mon, Mar 23, 2026 at 07:14:25PM +0530, Manivannan Sadhasivam wrote:
> > >> > > > On Mon, Mar 23, 2026 at 08:39:55AM -0500, Rob Herring wrote:
> > >> > > > > On Mon, Mar 23, 2026 at 7:16 AM Manivannan Sadhasivam <mani@kernel.org> wrote:
> > >> > > > > >
> > >> > > > > > On Sun, Mar 22, 2026 at 06:37:13PM -0500, Rob Herring wrote:
> > >> > > > > > > On Tue, Mar 17, 2026 at 09:59:56AM +0530, Manivannan Sadhasivam wrote:
> > >> > > > > > > > Lenovo Thinkpad T14s is found to have a soldered down version of M.2 1620
> > >> > > > > > > > LGA connector. Though, there is no 1620 LGA form factor defined in the M.2
> > >> > > > > > > > spec, it looks very similar to the M.2 Key E connector. So add the
> > >> > > > > > > > "pcie-m2-1620-lga-connector" compatible with "pcie-m2-e-connector" fallback
> > >> > > > > > > > to reuse the Key E binding.
> > >> > > > > > >
> > >> > > > > > > What is LGA?
> > >> > > > > > >
> > >> > > > > >
> > >> > > > > > Land Grid Array
> > >> > > > > >
> > >> > > > > > > If not in the spec, is it really something generic?
> > >> > > > > > >
> > >> > > > > >
> > >> > > > > > Good question. Yes and No! LGA is not something that Lenovo only uses. Other
> > >> > > > > > vendors may also use this form factor. PCIe connectors are full of innovation as
> > >> > > > > > the spec gives room for hardware designers to be as innovative as possible to
> > >> > > > > > save the BOM cost.
> > >> > > > > 
> > >> > > > > innovation == incompatible changes
> > >> > > > > 
> > >> > > > 
> > >> > > > Yes, I was trying to sound nice :)
> > >> > > > 
> > >> > > > > > This is why I do not want to make it Lenovo specific. But if you prefer that, I
> > >> > > > > > can name it as "lenovo,pcie-m2-1620-lga-connector".
> > >> > > > > 
> > >> > > > > Depends if you think that s/w needs to know the differences. Hard to
> > >> > > > > say with a sample size of 1.
> > >> > > > > 
> > >> > > > 
> > >> > > > Sure. Will add the 'lenovo' prefix then.
> > >> > > 
> > >> > > Is it really Lenovo? Or is it some other module vendor, whose LGAs are
> > >> > > being used by Lenovo?
> > >> > > 
> > >> > > I remember that DB820c also used some kind of a module for the WiFi card
> > >> > > (which might be M.2 compatible or might not, I can't find exact docs at
> > >> > > this point).
> > >> > > 
> > >> > 
> > >> > I don't know. These kind of designs might be reused by several vendors. But
> > >> > considering that we should not make it generic, I'd go with Lenovo as that's
> > >> > the only vendor we know as of now.
> > >> 
> > >> ... and later we learn that other vendors use the same idea /pinout,
> > >> then nothing stops us from still telling that it's a
> > >> "lenovo,pcie-m2-something-lga". 
> > >> 
> > >
> > > How do you possibly know whether a single vendor has introduced this form factor
> > > or reused by multiple ones? Atleast, I don't have access to such a source to
> > > confirm.
> > >
> > I've not really been following this thread/patchset in detail; but want me to try and check with the T14s platform team if this device is specifically made for us (Lenovo) or not?
> > I doubt it is - we just don't do that usually, but I can go and ask the question if it will help resolve this (with the caveat that it could hold up the review for a bit and I may not be able to get a straight answer)
> > 
> 
> I can drop this specific patch in the meantime.
> 
> > My vote (for what little it's worth) would be to make it non-Lenovo specific. Then when the same part causes issues on another vendors platform I won't get asked questions about why Lenovo is breaking <other vendor> :)
> > 
> 
> Even if Lenovo prefix is used, it won't break other vendors. Just that we will
> end up adding more compatibles.
> 
> Anyhow, I'll wait for your reply and drop this patch for next revision.
> 

If you need a vendor prefix, I think "qcom," would be more appropriate
than Lenovo. This form factor is used by most vendors for recent
soldered Qualcomm-based wireless cards, not just Lenovo:

 - Dell XPS 13 9345 has exactly the same soldered M.2 card, I assume
   there are several other vendors as well.

 - https://www.sparklan.com/product/wnsq-290be/ is a third-party
   (Qualcomm-based) M.2 LGA 1620 card, in the block diagram the
   pinout is called "QM.2 1620 LGA 168pin".

 - If you press F9 while booting the ThinkPad T14s, you should get to a
   screen with "Regulatory Information". For the T14s, this screen says
   "Contains FCC ID: J9C-QCNCM825". This is the WiFi/BT module in the
   soldered form factor. If you look that up on the FCC website, the
   applicant for this module is "Qualcomm Technologies, Inc.". This
   seems to be some kind of "modular certification" that vendors can
   reuse/adapt without going through the whole process again.

Perhaps you should ask around inside Qualcomm? :-)

Thanks,
Stephan

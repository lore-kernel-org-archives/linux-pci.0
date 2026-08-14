Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6480846DFFC;
	Fri, 14 Aug 2026 12:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786711795; cv=none; b=hU72iEsCE8wqqF0hQI4YEBCfHMMLC6DA2sTaAecanYJHDFBvMlKeX7QKxDG72DmkY3rlbhdBvrRr4Xt8c2tRFMLvenn8M5SkGSWiwJLYwqwiSUEnzcOQp82GqmlCGNPI7PiEm7uNOts/UeuVO+IxBvwA/0d4xVt+M/Ngr8QxgrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786711795; c=relaxed/simple;
	bh=N6Wm7zvO1O97Kiw/b6HRbmjzTds561mSYObozWbWlp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdtxOcSDzDzXR9ITkjL+s0zwxAQmLpLAE98iIODtqPV9FsLa9jQgjvM6x/VxXT/5k0HJ+4j8ngzNxj6GV5uKL+DKNPQk5XBTpRVB0GSzic3TKGkMJCiYMvuH0c3LSC9UHzeFcTqjgeBbSYUPM/sGuQlZZ0ni7/XaEzRSQ6Br3zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWTGi5Q7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWTGi5Q7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80B61F000E9;
	Fri, 14 Aug 2026 12:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786711787;
	bh=/N/HX1GSPPOcqxWY/4dtIRIphxWYu1pio+UkOSgheTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YWTGi5Q7f/pZmJbmyIgbKJXzr77Dl+/MMrgnXHtQhpdZC8lW4AM2lJ29i/13HYRdd
	 ZQKimYvkaspsstjrhlp1dq/ocDqT+e9aYeFGesZYVmKzima9JfENh95wImTEFhAOOF
	 InlnEDgETc0DXUW/G9AqEj8peU3XxtQ8u3hD8h31hatop8+Hh8AjZU393+lWriyc/Z
	 EVITiCpW6A/dgpEBJrpHeJdXAzSOokK69IItB/oZQJMvMjkSmvkKYCrS9oZWm39vIJ
	 V0pIfa1+uydAKd2dHEyqaNtmy1/312M8sPv1nFW1nNhSKMxOOlcZBEOhOyutdrHw5Y
	 mPs6QRNcCyzvA==
Date: Fri, 14 Aug 2026 14:49:31 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	manivannan.sadhasivam@oss.qualcomm.com, Rob Herring <robh@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-acpi@vger.kernel.org, 
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: Re: [PATCH v3 03/14] software node: Implement device_get_match_data
 fwnode callback
Message-ID: <ks2nm67zp5i2grzomu7mjb7uhkuwtd7w5stoqp5kri2clpxpsp@ayn42h7meh5l>
References: <20260110-pci-m2-e-v3-0-4faee7d0d5ae@oss.qualcomm.com>
 <20260110-pci-m2-e-v3-3-4faee7d0d5ae@oss.qualcomm.com>
 <aWSpFk9z0zpyKjr6@smile.fi.intel.com>
 <6l3rs5pv6xnrbygpvqrdxqoqtybjyefsltk5bl4336q56rfoza@ejo3sxuufghe>
 <aWSwgRiEkT9unYw9@smile.fi.intel.com>
 <6peb6afhpm4l7opxbdt3b5sx32longevwds5c3dlqji2hr5dlh@kxuvj55jkqgi>
 <ljqd5ovcsg7t62tdzd77w5mv5buawm3x7xyapy7n7l7azcaorh@tytj46t2lxyb>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ljqd5ovcsg7t62tdzd77w5mv5buawm3x7xyapy7n7l7azcaorh@tytj46t2lxyb>

On Mon, Jan 12, 2026 at 10:01:23PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Jan 12, 2026 at 02:32:21PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Jan 12, 2026 at 10:27:45AM +0200, Andy Shevchenko wrote:
> > > On Mon, Jan 12, 2026 at 01:49:54PM +0530, Manivannan Sadhasivam wrote:
> > > > + Dmitry Torokhov (who was against this patch previously)
> > > > 
> > > > On Mon, Jan 12, 2026 at 09:56:06AM +0200, Andy Shevchenko wrote:
> > > > > On Sat, Jan 10, 2026 at 12:26:21PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > > > 
> > > > > > Because the software node backend of the fwnode API framework lacks an
> > > > > > implementation for the .device_get_match_data function callback.
> > > > > 
> > > > > Maybe this is done on purpose. Have you thought about this aspect?
> > > > 
> > > > IMO, software nodes were introduced to add sub-properties to the existing
> > > > firmware nodes, but it has usecase/potential to go beyond that. More below.
> > > 
> > > Potential doesn't mean the necessity.
> > > 
> > > > > > This makes it difficult to use(and/or test) a few drivers that originates
> > > > > > from DT world on the non-DT platform.
> > > > > 
> > > > > How difficult? DSA implementation went to the way of taking DT overlay
> > > > > approach. Why that one can't be applied here?
> > > > 
> > > > Sometimes you do not have any DT node at all.
> > > 
> > > Yes, that is exactly the case I have referred to. The PCI core (in Linux)
> > > is able to create DT subtree on non-OF based platforms.
> > > 
> > 
> > Maybe I should look into creating dynamic DT node for the device and insert it
> > to the uart node. Theoretically it should work.
> > 
> 
> It worked flawlessly. So I sent v4 incorporating this design:
> https://lore.kernel.org/linux-pci/20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com/
> 

Andy, I had to revive this old thread of a merged series as Krzk is not in
favour of adding DT overlay or dynamic OF nodes for these BT devices [1]. His
objections are due to the fact that we are just adding BT nodes of a
discoverable device (M.2 PCIe device) without any resources. So the node just
contains the compatible to match with the serdev driver and nothing else.

And he suggested to use swnodes or other similar mechanisms to plug with the
serdev driver as that's the only thing we want here, not a true hardware
description.

Since you strongly objected the swnode approach in this series, I wanted to hear
your opinion before I rework the code.

- Mani

[1] https://lore.kernel.org/linux-pci/768142f0-2638-41f3-a34f-dc80bb99eb7f@kernel.org

-- 
மணிவண்ணன் சதாசிவம்

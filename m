Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B219A1A3160;
	Mon, 31 Aug 2026 13:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181375; cv=none; b=roO945B8KuWAl6RaSweciDI/Zn8dbxHFQ6R04pfLp8ZWD92U6d4/a2DY6z2O15L2lg2ZfAxGIpg9p7SWkiGANrdf+tRouiceJVABc2Ko5VLioXcRhDXuOXLd4u19yLdXs8TPi0pCKC8qLxIInSMWs/JidE38CGI2Lo0wwZDKDaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181375; c=relaxed/simple;
	bh=DgUGDzDsFcaHkO/kfFjyblEG2ccdokJ8aFjLP+oZEss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2kD7ZJXZItgnzoNEVKZzFl4LXicGkLYwVqwlLMkZtX2B/JdlTUPfYmCvzDN9xmv/3wZC60vuGnhuyPAHU+I4cI5/B9yFXL/0+pqTt0mrBA9b3sZf3Fru8EVY0qdKonnM24REHyHzvOnPpzVBk5vbnOksUZOibXrQE3coiisYcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W95mgbnZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W95mgbnZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37371F000E9;
	Mon, 31 Aug 2026 13:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788181374;
	bh=Vh+bXtqB0JrmOUc7Cfb62eydik9BcrlwIErB4WGzYVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W95mgbnZSp3BKeR7gGy563E1S8nGYEOO9jEEqz96V9WeLaRNbpV394kayreuxjKfO
	 ucfpy3x7RxAUezg6X9VoVkKpUSmQIRwz/iuFDRfJn6q4nKl0+Yo4Mf13WJcluJwKmZ
	 cYTWrSHszAGqUVQtdChncE2y29CuqlSqoGhMHtTzdnvIojdK/dxMpxaGKNrZrutfPy
	 0+osd4l8GKdnaU+l2Nsgy8ZfLgcDAVVvpWFHak3w4H9iij3MFGPKosrd7+ReK0hg+7
	 Te1kuVXW6ni0cgIcHVdT2LJ0Wvn1jq1zBsJ9xg+FWrFPIY04pM1MCVRRVHhvkg8G59
	 FXLsUTQYOiZ9w==
Date: Mon, 31 Aug 2026 15:02:29 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	linux-acpi@vger.kernel.org, Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: Re: [PATCH v3 03/14] software node: Implement device_get_match_data
 fwnode callback
Message-ID: <vawuqud4z54ucbj4j4sbu5de3vh7fz6q7kvlluaw36vko443ki@7qdmd3trra2n>
References: <20260110-pci-m2-e-v3-0-4faee7d0d5ae@oss.qualcomm.com>
 <20260110-pci-m2-e-v3-3-4faee7d0d5ae@oss.qualcomm.com>
 <aWSpFk9z0zpyKjr6@smile.fi.intel.com>
 <6l3rs5pv6xnrbygpvqrdxqoqtybjyefsltk5bl4336q56rfoza@ejo3sxuufghe>
 <aWSwgRiEkT9unYw9@smile.fi.intel.com>
 <6peb6afhpm4l7opxbdt3b5sx32longevwds5c3dlqji2hr5dlh@kxuvj55jkqgi>
 <ljqd5ovcsg7t62tdzd77w5mv5buawm3x7xyapy7n7l7azcaorh@tytj46t2lxyb>
 <ks2nm67zp5i2grzomu7mjb7uhkuwtd7w5stoqp5kri2clpxpsp@ayn42h7meh5l>
 <aoKrmZzmYsyvRJ-5@ashevche-desk.local>
 <aoMGJqwcEAHWmZX9@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aoMGJqwcEAHWmZX9@black.igk.intel.com>

On Mon, Aug 17, 2026 at 03:01:26PM +0200, Andy Shevchenko wrote:
> On Mon, Aug 17, 2026 at 09:35:05AM +0300, Andy Shevchenko wrote:
> > On Fri, Aug 14, 2026 at 02:49:31PM +0200, Manivannan Sadhasivam wrote:
> > > On Mon, Jan 12, 2026 at 10:01:23PM +0530, Manivannan Sadhasivam wrote:
> > > > On Mon, Jan 12, 2026 at 02:32:21PM +0530, Manivannan Sadhasivam wrote:
> > > > > On Mon, Jan 12, 2026 at 10:27:45AM +0200, Andy Shevchenko wrote:
> > > > > > On Mon, Jan 12, 2026 at 01:49:54PM +0530, Manivannan Sadhasivam wrote:
> > > > > > > + Dmitry Torokhov (who was against this patch previously)
> > > > > > > 
> > > > > > > On Mon, Jan 12, 2026 at 09:56:06AM +0200, Andy Shevchenko wrote:
> > > > > > > > On Sat, Jan 10, 2026 at 12:26:21PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > > > > > > 
> > > > > > > > > Because the software node backend of the fwnode API framework lacks an
> > > > > > > > > implementation for the .device_get_match_data function callback.
> > > > > > > > 
> > > > > > > > Maybe this is done on purpose. Have you thought about this aspect?
> > > > > > > 
> > > > > > > IMO, software nodes were introduced to add sub-properties to the existing
> > > > > > > firmware nodes, but it has usecase/potential to go beyond that. More below.
> > > > > > 
> > > > > > Potential doesn't mean the necessity.
> > > > > > 
> > > > > > > > > This makes it difficult to use(and/or test) a few drivers that originates
> > > > > > > > > from DT world on the non-DT platform.
> > > > > > > > 
> > > > > > > > How difficult? DSA implementation went to the way of taking DT overlay
> > > > > > > > approach. Why that one can't be applied here?
> > > > > > > 
> > > > > > > Sometimes you do not have any DT node at all.
> > > > > > 
> > > > > > Yes, that is exactly the case I have referred to. The PCI core (in Linux)
> > > > > > is able to create DT subtree on non-OF based platforms.
> > > > > 
> > > > > Maybe I should look into creating dynamic DT node for the device and insert it
> > > > > to the uart node. Theoretically it should work.
> > > > 
> > > > It worked flawlessly. So I sent v4 incorporating this design:
> > > > https://lore.kernel.org/linux-pci/20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com/
> > > 
> > > Andy, I had to revive this old thread of a merged series as Krzk is not in
> > > favour of adding DT overlay or dynamic OF nodes for these BT devices [1]. His
> > > objections are due to the fact that we are just adding BT nodes of a
> > > discoverable device (M.2 PCIe device) without any resources. So the node just
> > > contains the compatible to match with the serdev driver and nothing else.
> > > 
> > > And he suggested to use swnodes or other similar mechanisms to plug with the
> > > serdev driver as that's the only thing we want here, not a true hardware
> > > description.
> > 
> > SW nodes are not for describing HW from scratch. They are for fixing missing
> > pieces. If you can justify your case as a missing piece for the *existing*
> > device (which is enumerated using standard mechanisms), you can add a property
> > that fills the gap.
> > 
> > Unfortunately I see that there are `PROPERTY_ENTRY_STRING("compatible", ...)`
> > cases in the kernel (only 9 drivers so far), and I can't say if they describing
> > missing pieces or a SW-made descriptions of the hardware. For the latter the
> > DT/ACPI/other means but swnodes should be used.
> 
> I have read all replies by @krzk and the question here, why don't you use
> auxiliary bus? It seems the best suit for the case.
> 

I agree and I realised it very late. I've prototyped aux device locally and it
works.

Will submit the rework after some more testing, thanks!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

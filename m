Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794832061;
	b=oBoUlboc2QAKK2OXt71E8nlMMaffvHT1bg9XA6MsfylNi7KgF3w6VeXD0+1DtcV2D37k
	 X4IBGoBpE0bU2U0CGULTOX8vUlfFXo9/QJWqNx6/GmzD83kL36IZQKok+zqrAIC69SP2d
	 16ZU9FML2fq2hP4qE6T9fhuV6pzYhzZhB6Y/ldZtLrLAbuaYQoMz1HEZq4aMz+/EKRYRG
	 OgR1S6H3iIy3aEA3F5sJPtLXI3Bl92dSmwslyjW0h2iFlBPSxg48eZkjuISlg4sxiP486
	 +mxvKawIY6saKBQ/V7NY0rGc4gfMyJ4+agoWFsusOKeH0c0JSM9sn+w8Qm69AQDobxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794832061;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=wuf/Vb21lAKIWx5bIMQ7gAQDptG7l3Y/m/xV4mQ2rWs=;
	b=e4oaMBotb5n/8h+rcirX3H74E9CVxNx9ZBkP1O1BFS22wBKKp2hr0SU9u96k6ahayhK8
	 Esd2ETWrLOkT7fhpXwGySd8y/A8MEjm9J3UQaICnPl/4cneNqLffSAad5HW9n4SWPVugH
	 Fed1UI9mDVb933lfe/yjNXfykDKhAyeWKVhiad91876UUk/xh9T65osDU9vI3fIwBr6Vs
	 lvZIb4zGHKgXzeKfJKUi9KE9QTmfAhjsCUf1rP4oGpF3O/CGUjdzcFqyA30vSswx9WD3s
	 kQ6RtyoT6dYBsQj2wIDzL5jcSpGVJPuNN/NOjbG5hATzgAhj+oWgqkujLSDm75f1zDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WUogbiZ9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB9E606A31C;
	Mon, 16 Nov 2026 12:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WUogbiZ9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9EA1F000C4;
	Mon, 16 Nov 2026 12:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794832060;
	bh=wuf/Vb21lAKIWx5bIMQ7gAQDptG7l3Y/m/xV4mQ2rWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WUogbiZ9t9BJObRmhrxViyzM4DGbGCmdWU+/J509gYJyRcdNJqmvKcp/LNe2UB2Rz
	 0DQXi+ux8crszv2ki8laXp/UrNNxVXcFFr4Q3hIGMcvsEezkaLulNItc8mPYn6GXfe
	 Y9wkoN9KmMwSPc3TN3NhdHrOKfTZwDqEv6xsqeL1QTjvZpgIVECXvvOpSwzLXLu2C4
	 UOnZ1gU/GEz06RPdx3Cv+dW1/R7Te7qGMzGucBd4Yl5lDnQt1Ytn2jqIqj48xRjqGw
	 kUidydPVFHybinuOJj7J4/beXvQjyP4vFINKWCnzqOlbVXIIwXzobkoHreU29LfZ8h
	 vmWM2c8JsAHYw==
Date: Mon, 16 Nov 2026 14:27:36 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Johan Hovold <johan@kernel.org>, Eric Dumazet <edumazet@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
	linux-input@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
	iommu@lists.linux.dev, Jason Gunthorpe <jgg@ziepe.ca>,
	Alexey Kardashevskiy <aik@amd.com>
Subject: Re: [PATCH v2 11/19] driver core: Introduce a generic device trust
 level
Message-ID: <20261116122736.GL11319@unreal>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-11-3b12d9a9f861@nvidia.com>
 <de5772b3-c340-4822-a49a-1434ece1b144@ozlabs.ru>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de5772b3-c340-4822-a49a-1434ece1b144@ozlabs.ru>

On Fri, Nov 13, 2026 at 10:30:23PM +1100, Alexey Kardashevskiy wrote:
> On 9/11/26 18:33, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Device setup needs a common operating policy before driver probing or DMA
> > configuration. Userspace must be able to hold devices disabled until it
> > authorizes them.
> > 
> > Add generic trust admission with an immutable global boot policy. Restrict
> > the compatibility attachment API to explicit global full policy and full
> > operation, checking admission before probe. Keep the operating level
> > stable until teardown and retain normal locked admission for other callers.
> > 
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

<...>

> >   #define to_driver(obj) container_of(obj, struct driver_private, kobj)
> > +enum device_trust_state {
> > +	DEVICE_TRUST_SELECTABLE,
> > +	DEVICE_TRUST_WAITING,
> 
> What is the exact difference between these? "Waiting" is waiting for what?

This is internal device trust state which is not visible to the users.
In this state driver is not yet allowed to be bound, but once will be
approved, the driver will be able to continue.

The difference between DEVICE_TRUST_WAITING and DEVICE_TRUST_SELECTABLE
is what happens when you choose a policy: SELECTABLE allows further changes
before admission, while choosing adversary or full from WAITING immediately
locks that choice.

> 
> > +	DEVICE_TRUST_AUTHORIZED,
> > +	DEVICE_TRUST_COMMITTED,
> 
> And exact difference between these two? Some documentation would be great.
> 
> dev->trust_policy is how we want the device to operate.

Yes

> dev->p->trust_state is where the device is on its way to that final policy.

Partially, it is not only takes into account authorization (where the
device on its way), but also commitment (what is possible to do).

<...>

> > +static int __device_trust_prepare(struct device *dev,
> > +				  const struct device_driver *drv, bool full_only)
> > +{
> > +	enum device_trust_policy policy;
> > +	enum device_trust_level level;
> > +	int ret;
> > +
> > +	policy = dev->trust_policy;
> > +
> > +	if (policy == DEVICE_TRUST_POLICY_DISABLED)
> > +		return -EPERM;
> > +	if (dev->bus && dev->bus->trust_resolve) {
> > +		ret = dev->bus->trust_resolve(dev, drv, policy, &level);
> > +		if (ret)
> > +			return ret;
> > +	} else {
> > +		level = policy == DEVICE_TRUST_POLICY_ADVERSARY ?
> > +			DEVICE_TRUST_ADVERSARY : DEVICE_TRUST_FULL;
> > +	}
> > +	if (level == DEVICE_TRUST_DISABLED)
> > +		return -EPERM;
> 
> This check can go right after trust_resolve() above. Thanks,

Right, thanks

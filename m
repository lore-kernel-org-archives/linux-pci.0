Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73853DEFF7;
	Wed, 11 Mar 2026 12:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773231223; cv=none; b=jk9m9r8OXUMDvKeIZsIixSx7WEfKTYoVzlY8+swM7Ar8dLMNQqX6KyklNcOLTXz0c/b8lpP9XUK0Mw52Wy6Shq4a9lFoyOcNjCpFS6RcXdYBaSDHqvffADrsKQb+EQf0zI4yrP5BNp24iv76pv45qlXQ6YQVjHRTrS31G8gSjd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773231223; c=relaxed/simple;
	bh=eIF0LHq5EjuE0G5uZIgYim19/GJ+ngAdSsJDrDYWfD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3eA21C8Vgv1zuSuEXrO1BprVsnmk/jQLmp7D6yUfAuo7FsvrmVr5QbzZ6jPdmix5GjvnMoZlAWCD4S2o6PvB3mYcOSDQSJ0S0FRWLJmyXX47ErSdxuG1nOIBmkKE+vhpCvnWKsAQO+rOmjbKusYGNhkBOpMbIzPhq6KDI1QhAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcwx+uK4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcwx+uK4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFDC2C4CEF7;
	Wed, 11 Mar 2026 12:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773231223;
	bh=eIF0LHq5EjuE0G5uZIgYim19/GJ+ngAdSsJDrDYWfD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fcwx+uK4CECDkkiNcQcHrQkqjpTAf9sp25oL40xUeGeGp3dmc19aySgnxxKTW4YVx
	 qp36aO11TymmE/ARwHk0ZtnGB15yuAFOxgtY1UqFqazONp44PxKwN1v2kGhxmj/C38
	 IsPgBBHO5rQ3/vPeCaccWRp1/PRec+Wfj9JD/p5hPus4MDWYBXy2WIM8xlog4INY8q
	 z2gjj23xerTnhOWoIrJekN3bC570oNsR78W81FXCa9jOLhQEF2J4hYqQKTEopxnEB+
	 A30uYriov7NAj6V4zzkpps7K78W4AP0BxbXxkBjvN520UxD3D4jWs0JNfvvSqlAM/i
	 RKyw5Qt6vM94Q==
Date: Wed, 11 Mar 2026 13:13:34 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Hans Zhang <18255117159@163.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Anand Moon <linux.amoon@gmail.com>,
	Grimmauld <grimmauld@grimmauld.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	driver-core@lists.linux.dev, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v3] PCI: dw-rockchip: Enable async probe by default
Message-ID: <abFcbmkb9p0hx3NR@fedora>
References: <20260226101032.1042-1-linux.amoon@gmail.com>
 <177260693908.10259.13055467642416391434.b4-ty@kernel.org>
 <87bc37ee-234c-4568-b72e-955c130a6838@arm.com>
 <f7tfshf7riljjibuqge4ubfjmludubpyh3ppdf6lasurzdzbtj@sw4xxagfhnn3>
 <5d88fb5b-e771-4ea6-8d2c-c5cfd21e5860@arm.com>
 <qwanhqrpztzkudik5fmberhabnzaly7v53677dohqzj5nq4wi2@6ndpiubyxcbi>
 <DGZXF3LPSRK6.2QYN63QTKUQAX@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DGZXF3LPSRK6.2QYN63QTKUQAX@kernel.org>

On Wed, Mar 11, 2026 at 12:46:03PM +0100, Danilo Krummrich wrote:
> On Wed Mar 11, 2026 at 6:24 AM CET, Manivannan Sadhasivam wrote:
> > I have a contrary view here. If just a single driver or lib doesn't handle async
> > probe, it cannot just force other drivers to not take the advantage of async
> > probe. As I said above, enabling async probe easily saves a few hunderd ms or
> > even more if there are more than one Root Port or Root Complex in an SoC.
> 
> Then the driver or lib has to be fixed / improved first or the driver core has
> to be enabled to deal with a case where PROBE_FORCE_SYNCHRONOUS is requested
> from an async path, etc.
> 
> In any case, applying the patch and breaking things (knowingly?) doesn't seem
> like the correct approach.
> 
> > I strongly agree with you here that the underlying issue should be fixed. But
> > the real impact to end users is not this splat, but not having the boot time
> > optimization that this patch brings in. As an end user, one would want their
> > systems to boot quickly and they wouldn't bother much about a harmless warning
> > splat appearing in the dmesg log.
> 
> You mean quickly booting into a "harmless" potential deadlock condition the
> warning splat tries to make people aware of? :)
> 
> (Or am I missing a subtle detail and we can never actually end up in a deadlock
> for some reason?)

Right now it will print a warning even when trying to load a PHY driver that
is already loaded (e.g. if the PHY driver is built as built-in):
https://github.com/torvalds/linux/blob/v7.0-rc3/drivers/net/phy/phy_device.c#L806-L815

If the PHY driver is built as a module, then I assume that the deadlock
warning is legit.


Kind regards,
Niklas

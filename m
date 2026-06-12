Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23ED131F998;
	Fri, 12 Jun 2026 14:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781274522; cv=none; b=gHvEpugtLfxmTbrzFUQkZj+QZgBNmSuPzLe2r2dvXylADGu8MaBkaQqwGvYwsNfjIoMI8Uo+GccD9g+NZeS3NItdx5XdMrNL3mgh/kTSLgf5JUBZuubYovcalTR3vLToRwu0pDLEPUNptqHwb+TpShsVrRkMo1ME+OdhQoCUmDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781274522; c=relaxed/simple;
	bh=2/8e/puGPPpV3qL6kFsmt0QwFum0WgXEPXjqKIbftJI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bzTTDl50+BJ3A7mKQGvwyDWpAgb3pbKh/2OCP2/mzs9+O73y3jSMB0+dg9N5KI6DrosfmvNxk+GAsM6zP89qHLWakHmDBG8DAeVUA6xUH+Yk0iOB1hLEnUBzU1FvOWe3nmMoW0zVoHC8OPaklFKDoJP7EM8DOeF5FaadTRFsiCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Whtxs/6f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Whtxs/6f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CB51F000E9;
	Fri, 12 Jun 2026 14:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781274520;
	bh=DehFJsV485k7LTZXKfhC78GZT+1ibs1Znw6lXr1FMDA=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Whtxs/6fcijOkA6uvo6bpeD/BWoyHgsCgUoSKITE+iPzF0TXqdx44HOqaPkmSzAi9
	 XjCGK8L41tZkReTlq3d35V5+kleGD9J3nEHulqph4IYz4fn0iZj/Ns+0Ik6pE75M1M
	 6fwAV/ig2Ym9O50iMB+GjqoPD2o2PIWF4PZlC3+i10E3wYtq3nvbRqIcNlgjLh5hO1
	 +vcjyf8vpDmRLkb65Boxv/FAy93zSQFC2WTiTE/WZi+h8zzVwfh34c9SpuAVduKzeC
	 QHCrl/7mstTUQOyJNpbugm43uHGeFpa8x4kytzHY1im1LlFe4kpYeFYqTjwf2JzI0T
	 rcIt0uDpAK8zQ==
Date: Fri, 12 Jun 2026 09:28:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	linux-bluetooth@vger.kernel.org, linux-pci@vger.kernel.org,
	bhelgaas@google.com, ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com
Subject: Re: [PATCH v1 1/2] Bluetooth: hci_core: Add reset_type parameter to
 hdev->reset() callback
Message-ID: <20260612142839.GA598449@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZJY68zrRO49VEtgEVzQfqVY9QZzwUuc8VoKkAAeKUwAOw@mail.gmail.com>

On Fri, Jun 12, 2026 at 11:08:06AM -0300, Luiz Augusto von Dentz wrote:
> On Thu, Jun 11, 2026 at 10:29 PM Chandrashekar Devegowda
> <chandrashekar.devegowda@intel.com> wrote:
> >
> > Add a u8 reset_type parameter to the hdev->reset() callback to allow
> > userspace to select the reset method via sysfs. Writing 1 to
> > /sys/class/bluetooth/hci0/reset triggers a Product Level Device
> > Reset (PLDR), while any other value triggers a Function Level Reset
> > (FLR).
> >
> > The reset_type values are:
> >   0 - Function Level Reset (FLR)
> >   1 - Product Level Device Reset (PLDR)
> 
> This should probably be treated as a generic level at the sysfs level,
> then each vendor can interpret according to its own needs, for
> btintel_pcie that would result in the above levels.

Are you suggesting that this should be implemented in the
pci_dev_reset_methods[] framework in drivers/pci/quirks.c, so the
PCI-generic /sys/bus/pci/devices/.../reset interface could do the
PLDR?

That sounds worth exploring, although I really don't know anything
about the unusual multi-function model of some of these devices.
And the /sys/class/bluetooth/hci<index>/reset attribute already exists
and probably couldn't be removed.

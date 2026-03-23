Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403FF32C94A;
	Mon, 23 Mar 2026 19:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774292912; cv=none; b=L5MJD26CpgIHEeSpMQSEu514SZht6dpJ41AJunPFbkuh6pAQlZijbHAL6CjgyJRIDgjnQdl2hZ2sFETQMfQJ6EYOTUjz+vd8iE8XuJRyvjZ5OXihrCFqa6BkvgjFOHi7bh6acdsiHLfX/phuv1VbdSfsApjJU5gDUp/ozWDecRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774292912; c=relaxed/simple;
	bh=fND1i7XSRwnwhGWZNoGm4912eAP+A3jaUuMXaH7yais=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RySQoIqGJISKUzo/Y9ZBgdEPwvl92qv3wyAWbXdYqBIafafv/MIi6Nnu4l/vD/HIXP0auU59ja7RU7MSs1SJaPnszoKBjsa4Hulf3rIT1ZbZLf1qHurBXYJpTFXM02CvhJ6wv2qQ08r/x+Tg7EKMkSceHcXAOjd17HZFOZ4vk3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjHGSjH/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjHGSjH/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64655C4CEF7;
	Mon, 23 Mar 2026 19:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774292911;
	bh=fND1i7XSRwnwhGWZNoGm4912eAP+A3jaUuMXaH7yais=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hjHGSjH/Df10AQ25qwMPHhoyEddqmLCmbp4E4vSpccSPngmG8wk7aQxJAnhGeCpLl
	 fMkhlDlE+isU7No5v8/2rA131VikVJzx7sx/yZ8lubQj5AKwvKKJzQT/UdKcBo3ye3
	 6/eWOqrqz9l4ggc1/StbVso5NYr9G7TM+oVQcqePRQ5zyxumthpeNk0Z9VlA6gjD4Q
	 ortLHJBJ0znwLCqHs0UzAN21JQvPN5b91E0MMekW4DX/hnVKJfYWl74Ol0fIlGnx2I
	 fRlBfJt1tM5dwhu4ewEblXXmB68bamns6P87rCTAjJi1JY8xV6XNVYkG2gKm3BuCIO
	 aHkmEEz4NcABQ==
Date: Mon, 23 Mar 2026 14:08:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v3 5/7] PCI: mediatek-gen3: Integrate new pwrctrl API
Message-ID: <20260323190829.GA887140@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5HQY9nTCacUbNZL1XggiHqomhgiQH_gdFtXLra+_ut4fQ@mail.gmail.com>

On Fri, Mar 20, 2026 at 02:10:03PM +0800, Chen-Yu Tsai wrote:
> On Tue, Mar 10, 2026 at 12:49 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
> > On Tue, Mar 10, 2026 at 5:50 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Mon, Mar 09, 2026 at 01:24:34PM +0800, Chen-Yu Tsai wrote:
> > > > On Sat, Mar 7, 2026 at 4:59 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > On Mon, Mar 02, 2026 at 01:31:05PM +0800, Chen-Yu Tsai wrote:
> > > > > > With the new PCI pwrctrl API and PCI slot binding and power drivers, we
> > > > > > now have a way to describe and power up WiFi/BT adapters connected
> > > > > > through a PCIe or M.2 slot, or exploded onto the mainboard itself.
> > > > ...
> > >
> > > > > So now we have:
> > > > >
> > > > >   mtk_pcie_probe
> > > > >     mtk_pcie_setup
> > > > >       mtk_pcie_startup_port
> > > > >         mtk_pcie_device_power_up      <-- power up
> > > > >         mtk_pcie_device_power_down    # error path
> > > > >       mtk_pcie_setup_irq              # set up controller IRQ
> > > > >       mtk_pcie_device_power_down      # if mtk_pcie_setup_irq() failed
> > > > >     pci_host_probe                    # enumerate downstream devices
> > > > >     mtk_pcie_device_power_down        # if pci_host_probe() failed
> > > > >
> > > > > I think this is kind of a mess because mtk_pcie_device_power_down() is
> > > > > called from so many places, and some of them aren't connected to the
> > > > > mtk_pcie_device_power_up().
> > > > >
> > > > > In mtk_pcie_setup(), mtk_pcie_setup_irq() only deals with the
> > > > > *controller* IRQ and has nothing to do with the downstream devices.  I
> > > > > think mtk_pcie_setup_irq() should be done before
> > > > > mtk_pcie_startup_port() so we can abort before even powering up those
> > > > > devices.
> > > >
> > > > Makes sense to me. I think it can even be moved outside of mtk_pcie_setup()?
> > > > That way we don't have mtk_pcie_irq_teardown() in two error paths?
> > > >
> > > > I can send a follow up patch for that.
> > >
> > > What if we do those cleanups first?  That would make this patch quite
> > > a bit simpler and we wouldn't have to undo things.  It would be a
> > > shame to have a complicated patch to add this stuff, then another
> > > complicated patch to clean it up.
> >
> > Sure.
> >
> > > > > In mtk_pcie_startup_port(), mtk_pcie_enable_msi() and the PCIe
> > > > > translation window setup also don't have anything to do with the
> > > > > downstream devices, so I think they should be done before
> > > > > calling mtk_pcie_device_power_up().  The only thing there that needs
> > > > > the downstream devices powered up is waiting for the link to come up.
> > > >
> > > > My guess is that if the link up fails, then mtk_pcie_startup_port() is
> > > > going to error out anyway, so it maybe made sense to make sure a device
> > > > is actually present before doing any more work.
> > >
> > > Doesn't sound very convincing to me.  mtk_pcie_set_trans_table() and
> > > the window setup are local things with no timeouts or anything.  I
> > > think the logical structure is way more important than some kind of
> > > hand-crafted work avoidance.
> >
> > I understand. I merely meant that I have no actual knowledge of why it
> > happened, or if there are any concerns from the hardware side.
> >
> > > Separating the PCIe controller setup from things related to the link
> > > and downstream devices is pretty high on my list.
> >
> > Makes sense to me.
> >
> > I'll send an updated version.
> 
> I'm confused. I see this version in -next with the minor fixups from
> Bjorn. Do you want me to do the cleanups on top of them?

I had intended to defer merging pci/controller/mediatek-gen3 to
pci/next and wait for your updated version.  But I see that I forgot
about that and included the original version.  I rebuilt pci/next
without pci/controller/mediatek-gen3.

Bjorn

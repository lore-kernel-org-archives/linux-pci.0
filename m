Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B009186A;
	Tue, 12 May 2026 00:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778544074; cv=none; b=vCxEURjI5AtzB0rkmSB1erjKUkBsvd0qg2hnfMWb6Log2xoGwfLoImZ+LWN0eA88KTV/xWsodmAWGUIqklL83WCRFQ0ngP/9ZETXXE3vELg4FmxVP4vFfsood3OttRQLI96Ga0TrXJZGUDaeQccKXElv+yF0Fv+8uxEpFNEbkmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778544074; c=relaxed/simple;
	bh=6QhPxi1Bpzo7VZXAI2HFsk3GhApkVtrmWh/bdauxZAI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BgdFbV/T86yojctOZrF3Uk+XhNFIDgEA9B5wca4TvP5z7t4jf+bVs7/XxjJfM4lzg2kOZ35gB3NGn5Iz8Nk5f3VqiOJHlz+Er322qd9QhBd5XEjQnFlzWiiySNhTiwaxmW2cO+cQRO0L5N3U6RxA6vPR2JDNtvdnYGp11+hGcdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=om+9AuqH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="om+9AuqH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA63C2BCB0;
	Tue, 12 May 2026 00:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778544073;
	bh=6QhPxi1Bpzo7VZXAI2HFsk3GhApkVtrmWh/bdauxZAI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=om+9AuqHRa3ATwMB7jiREjGMmiBsOa/KTwgHlOIaTRFSo3rvE/UuJwUAAYaKFp9Q6
	 xfHeAZyGx3VNMCWcdjQXoynPEC/KCKvnbMg6Sqo7YCFwAcd1qD7EjDIZgm9Twqdlyh
	 gN/fGkN5wNq4Ivk2BQYHh3NmyiOCvmk0S2eAWJnUejbRXHTP/kxW/W5nSK4RaQWOON
	 mdCJ7QPMZA3YJaU1wOEodj+BmRSXm32VnfN4EZnv9iZdGrM7dEwx+yM1PzS9k4Xc/F
	 9xDGHumnWTkrNUWBk9/z8ET7aQ9Z+NaABvVtTorYX7jghgdjglXmDbIcWPy/GCyrz3
	 LKP/ducZLGHkA==
Date: Mon, 11 May 2026 19:01:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, sashiko-bot@kernel.org,
	linux-pci@vger.kernel.org, sashiko@lists.linux.dev,
	Marco Nenciarini <mnencia@kcore.it>,
	Michal Winiarski <michal.winiarski@intel.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Eric Chanudet <echanude@redhat.com>,
	Jean Guyader <jean.guyader@gmail.com>,
	Alex Williamson <alex@shazbot.org>, Sinan Kaya <okaya@kernel.org>,
	Mario Limonciello <superm1@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] PCI: Drop unnecessary retries when restoring BARs
Message-ID: <20260512000112.GA194667@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gU3fjh0czpp+7gC9EfRSwT2dUZQj0hSJR8VNwBLXM4PQ@mail.gmail.com>

On Mon, May 11, 2026 at 05:24:49PM +0200, Rafael J. Wysocki wrote:
> On Fri, May 8, 2026 at 11:43 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, May 08, 2026 at 02:51:37PM +0200, Rafael J. Wysocki wrote:
> > > On Fri, May 8, 2026 at 2:17 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Tue, May 05, 2026 at 12:43:17PM +0200, Rafael J. Wysocki wrote:
> > > > > On Mon, May 4, 2026 at 11:17 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> ...

> > > >     platform_pci_set_power_state(dev, PCI_D0);
> > > >
> > > >     pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> > > >     state = pmcsr & PCI_PM_CTRL_STATE_MASK;
> > > >     if (state == PCI_D0)
> > > >       goto end;
> > > >
> > > >     pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, 0);
> > > >     if (state == PCI_D3hot)
> > > >       pci_dev_d3_sleep(dev);
> > > >     ...
> > > >
> > > >   end:
> ...

> > OK, so after platform_pci_set_power_state(PCI_D0), the device may be
> > in D3hot in some cases.  Then there's a D3hot -> D0 transition, and we
> > do pci_dev_d3_sleep(), but not pci_dev_wait().  Sec 2.3.1 says RRS is
> > permitted after a D3hot to D0uninitialized, and pci_dev_wait() is what
> > waits and retries for the RRS case.
> >
> > It looks to me like we need pci_dev_wait() after that transition when
> > No_Soft_Reset == 0, i.e., something like the below.  Do you think this
> > is unnecessary?
> 
> Well, let me turn this around: Is there any evidence that it is necessary?

PCIe r7.0, sec 2.3.1, includes this:

  ◦ For Configuration Requests only, if Device Readiness Status is not
    supported, following reset it is permitted for a Function to
    terminate the request and indicate that it is temporarily unable
    to process the Request, but will be able to process the Request in
    the future - in this case, the Request Retry Status (RRS)
    Completion Status must be used (see § Section 6.6 ). Valid reset
    conditions after which a device/Function is permitted to return
    RRS in response to a Configuration Request are:

    ▪ Cold, Warm, and Hot Resets
    ▪ FLRs
    ▪ A reset initiated in response to a D3Hot to D0uninitialized
      device state transition

When No_Soft_Reset == 0, the D3hot->D0 transition is to
D0uninitialized, so I think the device is allowed to respond with RRS.

For the D3hot->D0 case, pci_power_up() already calls
pci_dev_d3_sleep(), which waits the 10ms required by sec 5.9, but it
does not currently account for an RRS response after that.

My argument is that if the device *does* respond with RRS, subsequent
config reads in callers of pci_power_up() will see invalid ~0 data
even though the device may become ready in the future.

For example, pci_set_full_power_state() reads PCI_PM_CTRL and may
incorrectly complain "Refused to change power state from D3hot to D0".

> I guess if it is not necessary, there will be no harm, but this is a
> performance-sensitive code path.

If the device is already Configuration-Ready, pci_dev_wait() will do
one additional config read, see a valid Vendor/Device ID, and won't
wait at all.

Bjorn

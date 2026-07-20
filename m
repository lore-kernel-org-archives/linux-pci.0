Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214773F076D;
	Mon, 20 Jul 2026 11:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784545461; cv=none; b=eHio1+GsqesMAHWlXROdFxPxUx6TI4jqHdVbVtkh2T0aa4vCD8mbHNr6IvErljzP9xQ5oOIVdEGxS+QdG181MQaO/ONF88wXXDRS2yxO25UDW06k+E9WV5rmJHwCofeyp01EbXTTxgQoKMgacmwIRL6PDbboxIDHpf2TRerrvdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784545461; c=relaxed/simple;
	bh=JPBfqQMUomalHJ9gmcBo7nD5KT00bTi3ymlGWqXDA+E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SoVwplH0vmzdZxmKJf6AVU38OWk5RNeZR6iZvhIlMMCqdgiFC7YPYVeCl0K9WRDeTHDrJHYRBQbQx5oo0GG5W8mSH8rGhBEtHVLH83n2qT2nr6jvPkwQpqdN0lpGnfaWQmRp2HepUczgC0CV494i+arN0qXybItbxd0rX+cV3Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuJZWerW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuJZWerW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B503E1F00A3A;
	Mon, 20 Jul 2026 11:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784545458;
	bh=0unQyipuPJ3aGBPKLnhRJ2e2d2GldgCfTJEWvdatTnM=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=WuJZWerWmr7AEddANj8j3T+wfm71SqZPK0tSG7LkKCuSZ4u9tfNXbnLFK4AS9S0Mh
	 d3oWSyJ7xt/j134vBZFg6frk5j3WUaQzUxx0B2pPWjb6kwWdq/ahiR8Qs24Z9PUoE6
	 oMe+RldvhXs7ntPD/19QSni6kgJDEZ39o2oGJNctnRz4A8OkOjyIAZGuml1wWIZKw8
	 +GDk+sAIdoyVepvacfD358VF07Ju4oBAKo/GS9RcFSLufcfN34bfEcx5TTrP+JlpD0
	 UBSRR99+nYXmmoStj63wL17qXHc6j3O90WEoG0oibwdjsmEe9QqSjJWIZrXnpmjpi5
	 kW8tBVa9ZAjSQ==
Date: Mon, 20 Jul 2026 06:04:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/pwrctrl: tc9563: take i2c adapter module reference
Message-ID: <20260720110417.GA321880@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <al30lyKsG3ywkiJu@hovoldconsulting.com>

On Mon, Jul 20, 2026 at 12:12:39PM +0200, Johan Hovold wrote:
> On Fri, Jul 17, 2026 at 11:58:41AM -0500, Bjorn Helgaas wrote:
> > On Thu, Jul 16, 2026 at 03:25:32PM +0200, Johan Hovold wrote:
> > > The i2c subsystem currently blocks during adapter deregistration
> > > whenever there are consumers holding a reference.
> > > 
> > > Switch to using of_get_i2c_adapter_by_node() which also takes a
> > > reference to the adapter module so that an attempt to unload the module
> > > while in use fails gracefully instead of blocking uninterruptibly.
> > > 
> > > Signed-off-by: Johan Hovold <johan@kernel.org>
> > 
> > Applied to pci/pwrctrl for v7.3, thanks!
> > 
> > Gemini suggested minor commit log rewording, let me know if it makes it
> > worse.  I do like the impact being mentioned in the subject:
> > 
> >   PCI/pwrctrl: tc9563: Avoid uninterruptible hang on in-use I2C module unload
> > 
> >   The I2C subsystem blocks during adapter deregistration if there are
> >   consumers actively holding a reference.
> > 
> >   Switch to of_get_i2c_adapter_by_node(), which also takes a reference to the
> >   adapter module, so an attempt to unload the module while in use will fail
> >   gracefully instead of blocking uninterruptibly.
> 
> No, please don't rewrite my commit messages (and especially not without
> clearly documenting that you've done).
> 
> If you have any concerns about the wording, I can try to accommodate
> those in a v2.
> 
> If I had considered this to be a fix (the line is admittedly blurry) I
> would also have tried to be more explicit about the impact in the
> summary. But here I think the existing summary is sufficient.
> 
> Note that I've sent similar changes for other subsystems and there is
> some value in using the same patch summary (modulo subsystem preferences
> for capitalisation, etc).

You're right, I'm sorry.  I used your original commit message.  I
assumed this was for v7.3, but let me know if it should be for v7.2.

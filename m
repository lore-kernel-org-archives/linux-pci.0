Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553B62931D1;
	Wed, 15 Jul 2026 04:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784089402; cv=none; b=JdCIxrT4cWSDx3/gF9yuJS295WGSNyJsECWcq4aM9k6K4ojBrdRVkNxEJKQPQp/hfIYLjEgEt6p79p3nUT8CTu2gokBYw+GH7XKVwUYfEOoA/kNU4C18cibAyewIE21Prq0zN9JTXvBzhgveyvfkPNI/+U1nW79PAWdOAhemdzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784089402; c=relaxed/simple;
	bh=n8meWVIJ6XoKqBHq7mfRFl6nWTKf4LXT6KDpYiegEYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T4quf5LiYysB2wfnoHljvIlSiYytylV/3VFcvrprIVDHNBSQI8vCcxCIAtDCC0n7IE7kG0M0VwiC8eOV5dlEWmyuXv1jDfyAnlvy2/icw7StvokXxsZQEPwXWbjOqY1o3OrlMTeV5YjWELYF8JOedCIyUQXmBO4Sf4SQhvMqGxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=QjsvMvZo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KnmFOFt2; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="QjsvMvZo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KnmFOFt2"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 33F2A7A012A;
	Wed, 15 Jul 2026 00:23:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 15 Jul 2026 00:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784089398;
	 x=1784175798; bh=NC4t+3SR0JHIfpIrEmQZGfemr+CE/kcOR6I9ANw2C4E=; b=
	QjsvMvZoLEwO3kyjh5vgJRlqkaQCsxHDs4lKiModb2lDh4y/qDkzStE0w0KIlDvi
	g/n4zNtKQ1zk/OfuJlwSJlQwf1uW7GEk5HAurr/4OCg+SRye5h40uPoHRfksIWk7
	+rG+NsYUW5ngJi+1r7mqKgm0UozBHdjYlvn+OHUFbuUv8vB34PMx0ijqazuDF7Pg
	c59SYHW2FThN7rn6YPQt43HEXw5655UmdI3c5607lHju8Vvh7L9V7b+vfvS9wBz3
	KPWTp7NUH1eVbtIuS9n7ZEudq1Ux0dVAY7YAtW6tgE25Mp/h9/s73fQw2eOm+e2M
	7mCvsxpzQ+5J3mYe7AN/Rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784089398; x=
	1784175798; bh=NC4t+3SR0JHIfpIrEmQZGfemr+CE/kcOR6I9ANw2C4E=; b=K
	nmFOFt2mPc5glEFy9amUZn/Epoj5TogmNIUyvFSL0f6ec5ve5zMR07jS/CGWWDEb
	5OMAaGIkPg8D5Z06rgjCFbmMpftk7IHR9JA5hAEPhX/XDdsyWrubISBJWCwepMs8
	riRxDotPm0a2ehvP6IMRUjsnYEiqy2sib8ATnv5ngfCR58d7u+ckgozedDPYVGN/
	oIC48ApOqPKIWZLM8ihw6IknJ6thhFoNAimPLsCmQHpGIlZUebsEs/r7B4JQbmAs
	tWZM3vGTifdPdBIiLZjCeWxcXa7O4WXOow6gNjtwp3/4PiNoV7CbvSPlc+3mwR+H
	rK2Aniflxi6FJq0qLT14g==
X-ME-Sender: <xms:NAtXagN_RDbwOUzuCyAyYoDvDkDPnImV55NsYNJzvd1rWmpIrbdGfA>
    <xme:NAtXaogDuYhfDfokqxw1djgioTaJ9IqEthJ-EWDOPgON8hE6S6tHQJu2yFprcDWYN
    s5YyVKN7l8lVMS5ZIsiizJIUYgKJS0yj-aWYtmrtU2pSLF7e3xP-A>
X-ME-Received: <xmr:NAtXamhH3eceCTMJy78RaZIpEJitCkN1eGFVApUzECAVrwCIF6rcYkr-3tqbQA>
X-ME-Proxy-Cause: dmFkZTEccTUvGxRRFY9lj/25aEwKQtu3a8rdNxW0FXCXubLh8bgQJAuyoMAUrFVusCxqc4
    1OEwrmvuBDR+6+fkapj+98QUwtAcZRQt/RhYd2wYzwGurzZcePzKA/ogsV8yFsDcF+esKT
    4DlBaHG7aQuqXJ4tGdebATyW6kkfykM37mVcOHJQEadZxdOKyy2hbeYLJ2DVHX6XxWDsDE
    nDD+WxeqtvvH5PllHjlacMZQk+MFxESQauoZoB6hIBy6F7JMNM9w2673F/7DxdLA89NxW4
    4SZ79EYgYlk2OAholROdVlQA3ChAfUXH2jDfufxtnlom6aLm+kJ1X4RAWGRVSchhAPj2NH
    4XE+dnNUpVEiEvnDPzYBa5lAgQL+cwnoH5KP5eH+I3SukGssfUrD6S3vV6OEmtb3CF8alC
    5gN1VZ/u2T2tJ2gLQNq4UBJ77Rh+pL3x39weZPpeBnqA8S/Oy2VShb+LbChUOW/UA7ED8c
    LEjEHg/ymoUgtO7DL2UR4j+RVNLiTMqJ4NN5XKifMyYtI+C17GF5/RksnKv9RyNSNE7kFi
    ceETqmTq2wGpPnqBFXSxkYUz2a0KWQUdsAKyHamaeYNxnZoKMReiq0NtAZSbboPQAC4uhA
    nJaAlSrZed1DjtsPEXbeE7J6l4toz7L8MZCnzano6UOteHThgroH1a47U5MA
X-ME-Proxy: <xmx:NAtXavKoPba2TFy-ijkk9Z9sxgJSQwWJDyyEQ1LChy5l69mevlRPFw>
    <xmx:NAtXatlou2Ia86UbNipi1H8fGJCljcVIz7Ok6OmptGGwPF7CR6g9hQ>
    <xmx:NAtXavMYdZLeOsEQhd1Qs6m9GUQwAQAhRHifzITrEoT-IBqppX33rQ>
    <xmx:NAtXav4SOscouLpu4Pbks3297enSj0lC2chRQ-or4x7ZDSye8Ucu6w>
    <xmx:NgtXatSSk_tneoAHrCOEPOKOg9xEYv6xdVnR4DxuFw_EZz1sEgV6-M_6>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 00:23:15 -0400 (EDT)
Date: Tue, 14 Jul 2026 22:23:13 -0600
From: Alex Williamson <alex@shazbot.org>
To: fengchengwen <fengchengwen@huawei.com>
Cc: <jgg@ziepe.ca>, <helgaas@kernel.org>, <wathsala.vithanage@arm.com>,
 <wei.huang2@amd.com>, <zhipingz@meta.com>, <wangzhou1@hisilicon.com>,
 <wangyushan12@huawei.com>, <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH v19 17/18] vfio/pci: Reset hardware TPH state on device
 enable/disable
Message-ID: <20260714222313.2fc9069f@shazbot.org>
In-Reply-To: <0fe381d6-8ea9-41d6-baf6-97db48b40aa0@huawei.com>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
	<20260702124224.57168-18-fengchengwen@huawei.com>
	<20260708172944.685c3cea@shazbot.org>
	<0fe381d6-8ea9-41d6-baf6-97db48b40aa0@huawei.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jul 2026 11:09:28 +0800
fengchengwen <fengchengwen@huawei.com> wrote:
> On 7/9/2026 7:29 AM, Alex Williamson wrote:
> > On Thu, 2 Jul 2026 20:42:23 +0800
> > Chengwen Feng <fengchengwen@huawei.com> wrote:
> >   
> >> VFIO allows user space to enable and modify PCI TPH state, but device
> >> reset only clears hardware TPH registers, while the software TPH state
> >> maintained in pci/tph.c remains stale.  
> > 
> > It's saved and restored, why is it "stale"?  It seems more that the
> > interface simply doesn't meet our use case.
> > 
> > What about resets through vfio-pci interfaces, should TPH be
> > automatically disabled?  Thanks,  
> 
> I initially added TPH disable logic into VFIO reset paths in v20 to make
> all reset scenarios consistent, but after reviewing Sashiko's feedback
> and re-checking PCI core state management, I agree we do NOT need extra
> pcie_disable_tph() calls in VFIO reset ioctl handlers.
> 
> VFIO reset ioctls eventually trigger the PCI state save/restore flow,
> which invokes pci_save_tph_state() and pci_restore_tph_state() to handle
> TPH capability and control registers properly. TPH configuration state
> will be restored to the saved value automatically after reset.
> 
> One important exception is the Steering Tag table when located in MSI-X
> vector space (PCI_TPH_LOC_MSIX). The pci_save_tph_state() helper only
> saves TPH capability registers; it does not back up ST entries stored in
> MSI-X table entries. After any PCI reset, those ST values are lost along
> with the rest of the MSI-X table and are not restored automatically.

False.  It's not restored as a separate TPH operation, the ST
upper/lower is stored in the MSI-X vector control register, which is
restored from kernel state (without a separate save-state function)
via:

__pci_restore_msix_state()
	pci_msix_write_vector_ctrl(entry, entry->pci.msix_ctrl);
 
> I will add explicit documentation to the VFIO_DEVICE_FEATURE_TPH_ST uAPI
> comments stating that userspace must re-program all ST table entries via
> this feature after any device reset, as ST entries are not preserved
> across PCI resets (especially for MSI-X backed ST tables).

Only DS is not saved and restored.

Alex

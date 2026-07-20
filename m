Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C5B3D9521;
	Mon, 20 Jul 2026 10:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784542373; cv=none; b=ZabclK+jY7MOIHKM8k6RHMJlINSiZCcSnQlXjuxQOfWFG3Mv4zYY9vqhjMpnDkX+fEImkqtlfM5kYP35wpnfNKGPBOg6OIYuVywxPBPjzKJ0UNfMGSFJsmzbGseFleNheGQ/FhEZtb84ZiJiTnYZkkBnXx7GAg3RQe0d3fK0b/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784542373; c=relaxed/simple;
	bh=Ey83jhah7qGbh3AegpQpC6Hr+8doRCQYf7OYaNI4p24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKLp25lcHCgh4+uLriplA9YaBvnmafIj0cfp/h36s+v1cN6AbbEEOKX9B0XX7eaU7V8rics+moxn1ODOmg4xl/jRS0P6VOna3NxyG5a5OybfPd9m2BVHZlFSiXYb0mP9gTBIWaV47Zjxb+G3s/14+KrEdOW2bbfarlog3giDTr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YU/OWLAo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YU/OWLAo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06661F00A3D;
	Mon, 20 Jul 2026 10:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784542361;
	bh=TXHvrQt1yJ/Vupm6KyQjZi4HDPJ836IxLcENYpPr3ZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YU/OWLAo7CohbMuq+o1u0dxXRlS4jOawSyei/n4T972jqJ4epX5gq6aw9bEo/+5lm
	 iA2O2ujDE/8ZupdUrrFcjLRnYJYxKtDWcdp1yD5/H8DldK9oZvk22WNlJEqzGVynni
	 suv/Zb+jcUX/AU4EyEbNw9sHyso6ULiSNAcNI0xzGwfKbY5i7pNdQs543ybAqxgMk/
	 cG760cOQGG0WLpeDOERq8CjE8xRT85IFwrgzD6il2ZufUlAYs16as4G1wBkUHnxICM
	 w2+NCEyHrVdHiMTHexkDP3MeShcJXyq9C2DrDRIFd+dFOqt5ddAY+mp9APXVPu4Pts
	 nXnDgffwbn1BQ==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wlkzH-00000008azT-17cT;
	Mon, 20 Jul 2026 12:12:39 +0200
Date: Mon, 20 Jul 2026 12:12:39 +0200
From: Johan Hovold <johan@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/pwrctrl: tc9563: take i2c adapter module reference
Message-ID: <al30lyKsG3ywkiJu@hovoldconsulting.com>
References: <20260716132532.1565340-1-johan@kernel.org>
 <20260717165841.GB11343@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717165841.GB11343@bhelgaas>

On Fri, Jul 17, 2026 at 11:58:41AM -0500, Bjorn Helgaas wrote:
> On Thu, Jul 16, 2026 at 03:25:32PM +0200, Johan Hovold wrote:
> > The i2c subsystem currently blocks during adapter deregistration
> > whenever there are consumers holding a reference.
> > 
> > Switch to using of_get_i2c_adapter_by_node() which also takes a
> > reference to the adapter module so that an attempt to unload the module
> > while in use fails gracefully instead of blocking uninterruptibly.
> > 
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> 
> Applied to pci/pwrctrl for v7.3, thanks!
> 
> Gemini suggested minor commit log rewording, let me know if it makes it
> worse.  I do like the impact being mentioned in the subject:
> 
>   PCI/pwrctrl: tc9563: Avoid uninterruptible hang on in-use I2C module unload
> 
>   The I2C subsystem blocks during adapter deregistration if there are
>   consumers actively holding a reference.
> 
>   Switch to of_get_i2c_adapter_by_node(), which also takes a reference to the
>   adapter module, so an attempt to unload the module while in use will fail
>   gracefully instead of blocking uninterruptibly.

No, please don't rewrite my commit messages (and especially not without
clearly documenting that you've done).

If you have any concerns about the wording, I can try to accommodate
those in a v2.

If I had considered this to be a fix (the line is admittedly blurry) I
would also have tried to be more explicit about the impact in the
summary. But here I think the existing summary is sufficient.

Note that I've sent similar changes for other subsystems and there is
some value in using the same patch summary (modulo subsystem preferences
for capitalisation, etc).

Johan

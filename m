Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BC02D8387;
	Thu, 19 Mar 2026 00:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773878420; cv=none; b=BXQ+RgsKZPkCA4h8rO7UlnELkg/dr3/BmkBwV3vZQiGg0F+zUYApR0SDc0I0vOu3Er63Uyk71EhHNjAe+4+l69RlVCwLOyIqCcxqCldMcyQ+QV5B/B3XMVLy5336X/V2Cwy3CE4CdwZ8ySBoz9tMPWLPZT0MFTxcpE4F7jRJRg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773878420; c=relaxed/simple;
	bh=7rDKEIezJCkg1O+c8sPftbNmz4kUGQQ7YCxFuSCBxVk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UFwmpblzh2J7cObCTLWKbXqOHTcpswa2nZVcd5FRZrlqRtFb3LtyyAOF8kM9quCRkoLnvX79GJwMbd+rgvYZH/5EV/ZP2LSvuM0udFCmQbIwe3QAp7cvm6atUzy9mUMYmHYEWgWRCTwo0Ui3u4nax2D2sc0DPAsQwePh5kelBaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1bI6lFi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1bI6lFi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6917FC19421;
	Thu, 19 Mar 2026 00:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773878420;
	bh=7rDKEIezJCkg1O+c8sPftbNmz4kUGQQ7YCxFuSCBxVk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n1bI6lFizaZQNVAeYZfV6+w2RPzzRLFr5V8WT0/jyAHIqkm9ktuJ0FPqhL81Vv1pP
	 8MSLmisTgKhvaHFsQxEkBwcqy/pj+EZZArVY5ep1IsmzCW8Rq7sBQcyg7dtbKvtrb6
	 TWWqa5DDZ99xm0+Wgz6BecJTGDdUie+M+6VWI0q1BeErG2jB3j8tpxPz4RL1N9ivC8
	 6K999o+AUDIm3xeR9DAgMCkSFUnbCb7UgvmxvOA4SLz1iu+BJesVz6eAWR7MDMdyRt
	 S4kY8F0dNrZ+B7E0iER7fKeikt5d0+dIfFr0vALuJsKeKAuYiIWfU/5btM8JRg5dJh
	 QJ4vc+j5Zh6tg==
Date: Wed, 18 Mar 2026 17:00:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
 <gregkh@linuxfoundation.org>, <aik@amd.com>, <aneesh.kumar@kernel.org>,
 <yilun.xu@linux.intel.com>, <bhelgaas@google.com>, <alistair23@gmail.com>,
 <lukas@wunner.de>, <jgg@nvidia.com>, Donald Hunter
 <donald.hunter@gmail.com>
Subject: Re: [PATCH v2 08/19] PCI/TSM: Add "evidence" support
Message-ID: <20260318170014.6650d2bf@kernel.org>
In-Reply-To: <69b8b234177ea_452b1001a@dwillia2-mobl4.notmuch>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
	<20260303000207.1836586-9-dan.j.williams@intel.com>
	<20260314111245.76d18d73@kernel.org>
	<69b8b234177ea_452b1001a@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 18:45:24 -0700 Dan Williams wrote:
> Jakub Kicinski wrote:
> > On Mon,  2 Mar 2026 16:01:56 -0800 Dan Williams wrote:  
> > > The implementation adheres to the guideline from:
> > > Documentation/userspace-api/netlink/genetlink-legacy.rst
> > > 
> > >     New Netlink families should never respond to a DO operation with
> > >     multiple replies, with ``NLM_F_MULTI`` set. Use a filtered dump
> > >     instead.  
> > 
> > My understanding of F_MULTI is that deserializer is supposed to
> > continue deserializing into current object. IOW if we have:
> > 
> > struct does_this {
> > 	int really;
> > 	int have_to;
> > 	int be_netlink;
> > };  
> 
> Heh, sensing a subtle message here...

One learns to optimize for conserving one's own attention wherever
possible :>

> > The main strength of Netlink is "do" commands with multiple optional
> > attrs.  
> 
> Yes, that is attractive and saves a pile of bug prone ioctl handling.
> 
> The gap I need to fill first though is a uAPI that allows for large
> blobs to be fetched after being regenerated / reformatted besed on some
> input attributes.
> 
> "Multi message netlink attributes" while inventive, feels less awkward
> and more future proof than a sysfs binary attribute scheme to do the
> same.

Alright, so to make this more Netlink-y you can either:
 - delete the F_MULTI and replicate other attrs in each message and 
   add an offset attr; this will make each message in the dump more
   standalone. 
 - keep the F_MULTI but object_val has to be a multi-attr, and then 
   we have to teach YNL to correctly append the attrs.

Former is definitely less work. Latter could end up being cleaner
but there are some unknowns so hard to tell for sure; more plumbing.

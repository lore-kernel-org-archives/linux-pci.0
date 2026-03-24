Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515E023D7E6;
	Tue, 24 Mar 2026 15:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774367346; cv=none; b=tTkwQ4Er0Mnn7jfMXtjunGusx23yDvOuNSOOPOzSyF3U9VIZSCqZyA1ks1TdOAgaP1h74Sje8jbS9exmK7t3/1rn0OqizpBsKSGvxEqxkHHkAfA8YT8L6aSzQ59DiGqquEO6MvSO7fCyTILlfE3IoXzTv/9EOTqukE0j8IDwlNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774367346; c=relaxed/simple;
	bh=w/nQhTLwo6qXEx9JHO5gNehu/T5aqNaQR0WU8hFdkak=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eo8Gq7ZWkC1n3XZWoI0RWQTsphqutoIqRkBtBG7PiM5a/HhJZ+AwpQiFSbrY6yod7yG6NimH12/loDbCMoSxZoCRO1rJ3w8FFlaNg+K2SWsdwryF91aVu7M4S45IuRaL7+GHXkHG9m7VlhQmNTwP4MUU5mUoJhh39VEew7kFv9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rO+cUUPC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rO+cUUPC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5B9C2BCB2;
	Tue, 24 Mar 2026 15:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774367345;
	bh=w/nQhTLwo6qXEx9JHO5gNehu/T5aqNaQR0WU8hFdkak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rO+cUUPCLvbAceeognw2e/QJwJ8EtmJNVxrozTVStVe5z02L0bCqI18RBAt1kyA1P
	 sG1ci5hywaLRmFnysgpudmsZggq2s96l6OGBGYKKPUSjpOVslfHrGI2OY8qt4ddgoi
	 32Kn8p5qoEnMHOx4KsGc5qsJPeP93QHD7R5Zw/NmWxAEeRQC2w6KWbWiB1vy5bap9t
	 tng9I9Vcc6KWRPZdNezYgQpcvPlmi2b2yp4P4ZIkCCTRqnczoBDhTgPt5r82c4bpfk
	 IoFvH5yAcpZYVJJa1QmSAYlY0Il8VuvwAWkfkTG/vZqpC6FMNPuYPjFEW6BtEY6QpG
	 f5AIvXEzbgXew==
Date: Tue, 24 Mar 2026 10:49:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/pwrctrl: Fix device node leak in
 pci_pwrctrl_is_required()
Message-ID: <20260324154904.GA1129159@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN4SLj2PRsaZnO_WptYQaQH4-DajrVd9L_=KXwTuOZj0kyLrOw@mail.gmail.com>

On Tue, Mar 24, 2026 at 06:05:18PM +0800, Felix Gu wrote:
> On Tue, Mar 24, 2026 at 4:57 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Mon, Mar 23, 2026 at 07:05:22PM +0800, Felix Gu wrote:
> > > The for_each_endpoint_of_node() macro requires calling of_node_put() on
> > > the endpoint node when breaking out of the loop early.
> > >
> > > Add of_node_put(endpoint) before the early return to properly release
> > > the reference.
> > >
> > > Fixes: cf3287fb2c1f ("PCI/pwrctrl: Ensure that remote endpoint node parent has supply requirement")
> > > Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> >
> > cf3287fb2c1f appeared in v7.0-rc5, so I put this on pci/for-linus for
> > v7.0, thanks!
> >
> > Would you also take a look at pwrseq_pcie_m2_match()?  It can
> > similarly return early from a for_each_endpoint_of_node() loop, so I'm
> > concerned it may have a similar issue.
>
> pwrseq_pcie_m2_match should be fine, endpoint is marked as
> __free(device_node), it will be called of_node_put() automatically
> when returning early.

Thanks, Felix, I indeed missed the __free() on the declaration.

For anyone else following along (and me the next time I trip over
this, since the connection from __free() to of_node_put() is somewhat
obscure), here's the connection:

  pwrseq_pcie_m2_match(...)
  {
    struct device_node *endpoint __free(device_node) = NULL;
    for_each_endpoint_of_node(ctx->of_node, endpoint) {
      if (...)
        return PWRSEQ_MATCH_OK;
    }
  }

  $ git grep "DEFINE_FREE(device_node"
  include/linux/of.h:DEFINE_FREE(device_node, struct device_node *, if (_T) of_node_put(_T))


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DBF372B57;
	Wed, 28 Jan 2026 18:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769626772; cv=none; b=Mc/980N0gQPc+YAZz5Ysz0HG0Ge9PJvCKDd9topTBD7gepMjGqUpZhwgLG//zjSqO6x/cQxtrXdWrvpwlIURf/Tq+4t0JpzkneZ58o4aOL1CFz+eoSBFxHEGdzCZLNOjwWR61FtoroApQIE/hFzkFv7/zGcuylBE2nWE/Jzw+r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769626772; c=relaxed/simple;
	bh=lAfWIXhDNPgKhfl+kFWnR4iuAVud1Cd3EevJcegc4Gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqTvpUP7/8OYwXWN4OAUxonAcMcMaBD7g8qqCCWFVPX1yGTs+u2ppC7bGiCZi6JqlEfDmxnNmnRLS+21rdWQtw5BM7eLA0/cgP3Qzr0Yz8lmf/KS0QDS3cZFoRYYcqS3fH3pOS0mkU1KDsooIzoaph2K8pep92AaSoDLN/mGJlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oof5qRSQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oof5qRSQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF09C4CEF1;
	Wed, 28 Jan 2026 18:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769626772;
	bh=lAfWIXhDNPgKhfl+kFWnR4iuAVud1Cd3EevJcegc4Gc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oof5qRSQqzkmWl0gjp70a+zLjMywhlphIg+tNbYl3T1Y1IcGNsy/pMSCi/tDmQwtJ
	 PGzDlGdZC0ycy7781Q5W4H5C24SMxX3CZlmGBgByrrjzbEipy9S+zJ5XDQMKpjwkFO
	 w6btjZSjVkiSFT4SlS3GxI4MM9UdDbNthsjvhgZ0Vk7c+KK2BoQfpIQtg+6ekEYMmM
	 czPPVWFUclMvglvkNiEqDw3ODkGqqhUO8u2icaBrZQ8GKAWn4vfr1KKbIOz4mcZTYq
	 EwTJy2j5qwWUkJnJCqQyUVPGigSqLpNRUVjWaaErsxskkk3Y+y42DXUSlgDAfCrOV0
	 r5fXe19H5dLsg==
Date: Wed, 28 Jan 2026 19:59:27 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>, Frank.Li@nxp.com,
	dlemoal@kernel.org, Koichiro Den <den@valinux.co.jp>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Allow overriding default
 BAR sizes
Message-ID: <aXpcj8MfxsbrKl4O@ryzen>
References: <20260123180747.827357-2-cassel@kernel.org>
 <yowgralxd7i55p63wqc7jxffwz5iqtrlztndpqu5yqeavhtscn@ajwd6r27ra6a>
 <aXo6w4AM-UgoyICd@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXo6w4AM-UgoyICd@ryzen>

On Wed, Jan 28, 2026 at 05:35:15PM +0100, Niklas Cassel wrote:
> On Wed, Jan 28, 2026 at 01:47:45PM +0530, Manivannan Sadhasivam wrote:

(snip)

> But I am slightly worried of the complexity it brings...
> Because we already have an .epc_init callback in an EPF driver.
> If we also bring add a ".pre_start_link" callback in an EPF driver,
> how should an EPF driver developer know what to put in each callback?
> 
> I guess in that case we would want to remove the .epc_init callback?
> 
> (Because calling .set_bar() etc. should work to be called in a
> .pre_start_link for both those driver relying on external refclock and
> for those that don't.
> 
> If you do
> # echo 1 > controllers/a40000000.pcie-ep/start
> on a platform that requires an external reflock, before the external
> refclock is available, that is your own fault.
> 
> I guess we could detect that and give a nice error.)

pci_epf_test_alloc_space() is called by pci_epf_test_bind().

pci_epc_set_bar() is called by pci_epf_test_epc_init().

On platforms that do not require an external reference clock to do
register writes to their own config space, i.e. all drivers except
(pcie-qcom and pcie-tegra194), a single configfs link command will cause
both both of these callback to be called directly after each other:

# ln -s functions/pci_epf_test/func1 controllers/a40000000.pcie-ep/
[  578.073152] pci_epf_test_bind
[  578.075614] pci_epf_test_epc_init


So, unless we want to change the design of pci-epf-test to:
1) Move the allocation of BARs from .bind() to a new
   .pre_start_link() callback.
2) Move the call to pci_epc_set_bar() from epc_init() to a new
   .pre_start_link() callback.
3) Remove the now unused .epc_init() callback.

...and for consistency, we would also need to do these steps for all
the other existing EPF drivers...

I am not convinced that it is worth reworking the EPF callbacks for this
(test driver) feature, which will only used for PCI endpoint developers,
especially given the complexity it would require.

For platforms drivers that require external reference clock, is it possible
to call
echo 1 > start

before we get refclock?

If so the design would probably need to be changed even more drastically...



When we introduce .epc_init, one of the reasons why we decided to have
alloc_space() and set_bar() in two different callbacks, was if a host driver
toggled PERST, the EPF driver would not need to call free() on the backing
memory it has allocated, e.g. I can see that pci_epf_test_epc_deinit() calls
clear_bar(), but the only place that actually frees the memory backing the
BARs is pci_epf_test_unbind().


What if the user wants to do:

# echo 1024 > functions/pci_epf_test/func1/pci_epf_test.0/bar1_size
# echo 0 > controllers/a40000000.pcie-ep/start
# echo 2048 > functions/pci_epf_test/func1/pci_epf_test.0/bar1_size
# echo 1 > controllers/a40000000.pcie-ep/start

Do we want to make the allocation each time we echo 1 > start... ?

If someone stops the link.. is it really wrong to free the memory?

I'm not against this design, but with the complexity that we want
.epc_init() to only call set_bar(), and we probably want .pre_start_link()
to call alloc_space()...

I don't think that the small feature in this patch is enough
justification to modify how all EPF driver to their backing memory
allocations just for this...

Instead I will just send a new version such that if the user get -EINVAL
if trying to change bar*_size in configfs AFTER the EPF has been bound to
an EPC (i.e. it can only be done before binding to an EPC.), as that seems
like the most pragmatic compromise that will avoid (another) redesign of
the EPF callbacks.


Kind regards,
Niklas

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA11139D0A;
	Fri, 23 Jan 2026 08:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769157306; cv=none; b=d8mPSM7lL942QTXk4In41awluYq+IqGQlCg8cVMhbXEVuS67/6KHwFubLzoJshnxB7Q3jx6/JQe7PjZDvR/2feBeKcMad2wNjtA/If7NEqH8v8PU6KK1WD8SSNvkEdnPXwO78FMm30zyodQtbr5PJZrE/odi/OtSKL1MND9DTzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769157306; c=relaxed/simple;
	bh=xMcJirGGprtvtsUBDME4ShjXeAElDCINrBoakRUw7K0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIfCBhgRwicz2q6aHnHOxLNBrwvMUsvNA3uUQVuK/1eMquq7m07u5SV58Mghn0rkbrbD8mgPJiBQjsqOpmbvA0qOAy4zNN5CQXQWI8xEqlFDnMAwOCxLM9v7fIqDeAii8QTjxwR9CK35udxNZGUyCJfL4fbMSgrHFYd3bghur5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SuObjVaj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SuObjVaj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67B8C4CEF1;
	Fri, 23 Jan 2026 08:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769157306;
	bh=xMcJirGGprtvtsUBDME4ShjXeAElDCINrBoakRUw7K0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SuObjVaj48VsHgQEgPs3sTSSb2f8TpAYg8XGqdxLvJq4XXHdTxJEe7asVpy7Me6qL
	 ok9xTCvzcsfheuwVsWhhJjSeR8DdeCxdkGOHr+pUvGcEUvPl3RkbSx0xMOblypibpG
	 Gf0+RC/kY8FDjLO1MnuspDe8eumfNrzuM/iF82sdHZRELfdeHJ0vbtVLetWyp+R1xj
	 9U7Un9bHy3Pkg8XV6Lp2VHnK5/MaNx6QxZtk22zIBVVaCBUV/karsqtFzrAWn1a/Nj
	 j6egxA7Y1O08UGvejaQ8bO9TdiY0Mjt6Kr+oivfiFErUWhT6CTDjQ+a1tEK0L1hb8/
	 0/Nvo25l+Wclg==
Date: Fri, 23 Jan 2026 09:35:01 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, bhelgaas@google.com,
	kwilczynski@kernel.org, frank.li@nxp.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/5] PCI: endpoint: BAR subrange mapping support
Message-ID: <aXMytcJTIeBHatIF@ryzen>
References: <20260115084928.55701-1-den@valinux.co.jp>
 <x64g63zkz5t75vxxlzd7rhbvpus2mmhz2phyvxykuax5wm5cnh@zgpomauf75pv>
 <ugxohcm4tvtjwnhkkz7jw226upm7o5hihohzn2f4eoamhkd77v@mjefdgxneghm>
 <waapztvy6jyjqtfcoo3rbgvagi4z3p5afw6x2acgf5bxatcui6@nkodhtqqtetr>
 <aXHfUyd0EPFnoVBO@ryzen>
 <tvaumsi4ahosz4herbxoc636fj3lhetjzqlwp5n4e34tthmn26@bld32k6xntmw>
 <aXI_ny1-5NlN8r_z@ryzen>
 <ajuq5dpbzzoghd2hk7cz6w4t6jzcxfmygbyiciqjjhhg6ipkoh@usuhzmne6cap>
 <nrvamhbpi4372c4qmb2q3h74irrqkntlb2rwfasiorgavylp25@rx2lp6ldk64j>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nrvamhbpi4372c4qmb2q3h74irrqkntlb2rwfasiorgavylp25@rx2lp6ldk64j>

On Fri, Jan 23, 2026 at 04:11:08PM +0900, Koichiro Den wrote:
> 
> One additional concern if we were to add a subrange mapping test is that
> the EP-side pci-epf-test.c currently defines bar_size as follows:
> 
>   static size_t bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };
>   (see https://github.com/torvalds/linux/blob/v6.19-rc6/drivers/pci/endpoint/functions/pci-epf-test.c#L105)
> 
> The values 512 (BAR0/1) and 1024 (BAR2) are even smaller than the minimam
> CX_ATU_MIN_REGION_SIZE (=4KB). This means that introducing
> BAR_SUBRANGE_TEST would likely require one of the following:
> 
>   (a). raising these hard-coded values
>   (b). reserving a dedicated BAR for the subrange mapping test
>   (c). limiting the testing to BAR3/4/5 if available (though, for
>        example, no BAR would pass the test on R-Car Spider which I'm
>        testing on, where BAR4 is fixed 256B).
> 
> I'm wondering whether there is a clean way to add a subrange mapping test
> without significantly reshaping pci-epf-test.

If you really want to implement a test, I suggest to look at:

pci_epf_test_enable_doorbell()
Which changes the address translation of a BAR dynamically.

pci_epf_test_disable_doorbell()
Which reverts back to the original translation.

pci_epf_test_enable_doorbell() simply does:
pci_epc_get_next_free_bar() to get a BAR, then writes the BAR
number in the in the pci-epf-test command registers, offset:
PCI_ENDPOINT_TEST_DB_BAR                0x34

(Which represent the offset in struct pci_epf_test, for
struct member db_bar)


However, the doorbells are most likely very small, so the chances
that reg->doorbell_offset will have a value that is smaller than
BAR size seems likely... but not guaranteed... and there is no

if (reg->doorbell_offset > epf->bar[bar].size)
    goto err_doorbell_cleanup;

So it seems that this doorbell test just ignores the problem...

Frank, could you perhaps send a patch to add something like the above?


For your case... I guess we could bump the default sizes in pci-epf-test
if we want to. pci-epf-test already does:

                if (epc_features->bar[bar].type == BAR_FIXED)
                        test_reg_size = epc_features->bar[bar].fixed_size;
                else
                        test_reg_size = bar_size[bar];

So if there are fixed size BARs, that size will be respected, so I don't
think there should be any problem to increase the default sizes, if we
wanted to.

E.g. RK3588 has CX_ATU_MIN_REGION_SIZE 64k

So if we wanted to, a good number would be to have at least a few BARs of size
128k or larger (so there could be two submaps), since I assume that some other
DWC controllers might also have have 64k min alignment.


Having a test for this feature in pci-epf-test sounds really nice.
You could have even add a capability for this, see
pci_epf_test_set_capabilities().

if (epf_test->epc_features->subrange_mapping)
	caps |= CAP_SUBRANGE_MAPPING;


Such that the host side driver (drivers/misc/pci_endpoint_test.c) could return
a distinct error code when this feature is not supported, such that
tools/testing/selftests/pci_endpoint/pci_endpoint_test.c could return SKIP when
that distinct error code is detected.


Kind regards,
Niklas

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7075C3590D8;
	Fri, 30 Jan 2026 22:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769813499; cv=none; b=CkOTi/T2ZO3vP+bjVnpP4z/Zz46L64aFODOgTJ04NIZzaMQuusG3iVu8w76eHbqVAhZTgUorCLFyEcnK4xeNzcDr7lcwcmhSM8vVndR1GKo5peIsQN1RxpharBUmnfRosZLeVRod9xJUQkvZooRPJTiBX5mkxUUUXu3mzRcU8tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769813499; c=relaxed/simple;
	bh=U+au43+QZxuZYBecWgw6CB7k20w6KPR9nf6OvAdwBa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EeK4vNfmXIZb3JHeAsgYrIaPH7rEMXpp63CylhlE2TgnImonsWJW5lYbxVFosbtnyfMKh8TaK5KDj7PvLweGv+j4IH5IxrfEgR5MGnAkbsl/iLRqMlcnO6n2CFdmFY6fXg4AALkfO7Us08pT4gjbga8eU0cULj0UwLXxMCIH2LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7f5roAD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7f5roAD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CEAC4CEF7;
	Fri, 30 Jan 2026 22:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769813499;
	bh=U+au43+QZxuZYBecWgw6CB7k20w6KPR9nf6OvAdwBa0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L7f5roADcRTW5jTBNIcfVjCmUYMuJ8S4MH5Gk3KzRFpMU7rHaJgtawp8PMsxpa7jC
	 y556UflqKCvXi2LiElLa20esqMPdrp4vwLn3ET3B3Mhwsg1862bFRICDwptoCS0nEP
	 G43kNjKa7u0Zde8GW5ojHXcX5pvwfuV3O3Q9Tngs7tiGyrujkwG4ejADOOzWnAWPcc
	 RQkO1KTLbSAIPd/KQOh97OcsUtPE0vgyWxTz40ri4x/WcAncFvse1pvWVM8yPhsWT0
	 W5QykY7uroaIH1Ej4XTealYdiefYODIH+2hfZU9nfjSIOj8EuOjhCwqG249VCK3+cW
	 DgH6fia+PD96A==
Date: Fri, 30 Jan 2026 23:51:33 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Aksh Garg <a-garg7@ti.com>, linux-pci@vger.kernel.org,
	jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	Zhiqiang.Hou@nxp.com, gustavo.pimentel@synopsys.com,
	linux-kernel@vger.kernel.org, s-vadapalli@ti.com,
	danishanwar@ti.com
Subject: Re: [PATCH v4 2/3] PCI: dwc: ep: Add per-PF BAR and inbound ATU
 mapping support
Message-ID: <aX019VTWjMlPX8qp@fedora>
References: <20260129091753.490167-1-a-garg7@ti.com>
 <20260129091753.490167-3-a-garg7@ti.com>
 <aXtrW7viGZfMNZur@ryzen>
 <s5hd43mnktvnuikuai25fhzchkt4y5w3ejabqhr43ihvwuefb3@wvatfe5k4loe>
 <aXyAfilrBOe1cEEk@ryzen>
 <q5e7ydmf4ra6x2mbxwifovgr6p6x5dfnz3hz5psq5ypyabtsvx@oq5ovi4o26yf>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <q5e7ydmf4ra6x2mbxwifovgr6p6x5dfnz3hz5psq5ypyabtsvx@oq5ovi4o26yf>

Hello Koichiro,

On Sat, Jan 31, 2026 at 02:16:37AM +0900, Koichiro Den wrote:
> While looking at this, I spotted a subtle corner case that the missing
> 'return' has been masking.
> 
> Consider the following re-programming sequence for a BAR:
> 
>   1) The initial set_bar() programs the BAR in BAR Match Mode
>   2) The second set_bar() switches the BAR to Address Match Mode
>      - Ad part of this, set_bar() calls dw_pcie_ep_clear_ib_maps() before
>        re-programming.
>   3) The third set_bar() switches back to BAR Match Mode.
> 
> In step (3), the current behavior depends on how the caller handles the
> struct pci_epf_bar passed to set_bar()
> 
>   a) If the caller passes a freshly prepared epf_bar with .num_submap = 0,
>      dw_pcie_ep_clear_ib_maps() is called as expected.
> 
>   b) If the caller updates the same epf_bar in place (i.e. reused the
>      object that passed in step (2)) and simply updates .num_submap back to
>      0, dw_pcie_ep_clear_ib_maps() is NOT called because the condition in
>      [1] evaluates to false. The recently merged (my) pci-epf-test code
>      follows this patter, see [2].
> 
> The point is that ep_func->epf_bar[bar] only stores a pointer, and the
> actual object is owned by the API caller. Since struct pci_epf embeds the
> BAR descriptors, updating an epf_bar in place (pattern (b)) seems quite
> natural and, in my view, should be supported.

(cut)

> Requiring callers to always pass a new epf_bar (pattern (a)) feels
> contrary to the current API/data-structure design.

I disagree.

I previously suggested that you should look at pci_epf_test_enable_doorbell()
and pci_epf_test_disable_doorbell().

If we look at the workflow in pci-epf-test for the doorbell test case:

1)
pci_epf_test_epc_init() calls pci_epf_test_set_bar() which calls
pci_epc_set_bar(..., &epf->bar[bar]);

2)
pci_epf_test_enable_doorbell()
uses a new struct pci_epf_bar (epf_test->db_bar)

copies the barno, size and flags for the BAR is will dynamically change:
epf_test->db_bar.barno = bar;
epf_test->db_bar.size = epf->bar[bar].size;
epf_test->db_bar.flags = epf->bar[bar].flags;
calls pci_epc_set_bar(..., &epf_test->db_bar);

3)
pci_epf_test_disable_doorbell() calls 
pci_epc_set_bar(..., &epf->bar[bar]);
with the original unmodified struct pci_epf_bar.


Your new test case however, reuses epf->bar[bar] in step 1, 2, 3.

I think the solution is to change your test case so that you use same
workflow as the doorbell test case. Just add a new struct pci_epf_bar
to struct pci_epf_test where you store the temporary BAR.


I'm not a big fan of your suggested code changes.

I think adding the early return in dw_pcie_ep_clear_ib_maps() and
modifying your test case to use a new epf_bar are the only things
that should be fixed as soon as possible.


> One downside is that this introduces a behavioral change in a specific
> failure case that already existed prior to this series.
> 
> Concretely, this only affects the traditional reprogramming path where a
> BAR configured in BAR Match Mode is updated again to BAR Match Mode. If
> such an update fails (for example, because the new epf_bar->phys_addr is
> not aligned to region_align), the behavior changes as follows:
> 
>   - Before this change: the previously programmed BAR Match Mode mapping
>     remains in place.
>   - After this change: the existing mapping is torn down first, so no mapping
>     remains after the failure.
> 
> I don't think this change is a major issue, since the caller will still
> observe the failure and should handle the error accordingly in either case.
> That said, I'd appreciate feedback if retaining the old BAR Match Mode
> mapping on such failure scenario is considered important for the existing
> update path.

You have found a potential problem with the API though, but like you said,
this problem was there even before your changes, so this problem can take
more time to be addressed.

Since the DWC EP driver only stores pointers to struct pci_epf_bar BARs
in set_bar(), it is theoretically possible for the caller to modify this
struct after calling set_bar(). This means that any future safety check
against values in ep_func->epf_bar (e.g. [1]) is unreliable, as the caller
could have modified the struct after calling set_bar().

[1] https://github.com/torvalds/linux/blob/v6.19-rc7/drivers/pci/controller/dwc/pcie-designware-ep.c#L368-L370

I think the solution to this is to modify struct dw_pcie_ep_func:

@@ -472,7 +472,7 @@ struct dw_pcie_ep_func {
        u8                      msi_cap;        /* MSI capability offset */
        u8                      msix_cap;       /* MSI-X capability offset */
        u8                      bar_to_atu[PCI_STD_NUM_BARS];
-       struct pci_epf_bar      *epf_bar[PCI_STD_NUM_BARS];
+       struct pci_epf_bar      epf_bar[PCI_STD_NUM_BARS];
 
        /* Only for Address Match Mode inbound iATU */
        u32                     *ib_atu_indexes[PCI_STD_NUM_BARS];



And then modify set_bar() to something like:

@@ -588,7 +588,7 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
        if (ret)
                return ret;
 
-       ep_func->epf_bar[bar] = epf_bar;
+       memcpy(&ep_func->epf_bar[bar], epf_bar, sizeof *epf_bar);
 
        return 0;
 }


But that would also mean that we need to modify the if (ep_func->epf_bar[bar])
with something like if (ep_func->epf_bar_in_use[bar])

Or... I guess we could keep it as pointers, but use kmemdup() in set_bar()
to get our own immutable copy, and then kfree() the pointer in clear_bar()
(and in set_bar() before kmemduping the memory, if the DWC driver already
has a local copy (i.e. dynamically changing the BAR without first calling
clear_bar()))


Kind regards,
Niklas

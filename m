Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC8E396B76;
	Mon, 30 Mar 2026 22:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774909265; cv=none; b=snzwjgq7LsefbBshk+mNjPd7b4QccMg9BzbPiwFfF0alOIelY9dHjhifqespvci05uXr4k9VN+/laU6eOdeBJWC83boFOzffknLC3+vKZmxapK2xvT56155G88KQWtGsS8LRQhJVeoxtRmyd+P+c9G9SdWXM1D4LbbkLBWTlIqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774909265; c=relaxed/simple;
	bh=Z7uV56hlfQ9pLrCukHTJCQOvvOCs3RGKHDjgLZ0nYMg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uIQ93ccODD1F2YfRNIvfSE+Z+jGK2vpNLCQ+QpzrVKRWRHA8BcQvtVOz3HgDh1v1+g77MiNkm93e6NJXu/9qeFdNiKyZogliIiQ603P7hIp2PWo7h1/wS7RLhnaKOXiMs2ZlFDCIMv2P6ndJzUFTUFUAAMWRRU8+ozppFpSTYpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnF8VaGq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnF8VaGq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CCD6C4CEF7;
	Mon, 30 Mar 2026 22:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774909261;
	bh=Z7uV56hlfQ9pLrCukHTJCQOvvOCs3RGKHDjgLZ0nYMg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=LnF8VaGqjHuPXP/rT2Qly9l/SPsw7L73y2AiSFPdX8b9orvH01g8fqf8xupv+eOdK
	 AMpYOm+GTv6yFsP1Q7oKLGvOUmdOEdzwyJvmx9nTFJm4P0eyACaretAH1ECUDvvbft
	 LS9l6fIWNvgOEFmJz5WQGhLRuoNl9kjzKpb0qI3gNwK3yCxZntU1qzK2Yd8EGo1aiH
	 kfkouAiDODU1dudxgpcwtB46IxoY/Ihtbv2ttalPDU+54ZroSyvNuukMqdW6klMLJp
	 72U1bEmTjfJEX83THdj26WG4DAbE+RnfM00+solTR6OriRzQbffOuWi9newTGntH1y
	 EioOjd9o3WcSg==
Date: Mon, 30 Mar 2026 17:20:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>,
	Jon Pan-Doh <pandoh@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Sizhe Liu <liusizhe5@huawei.com>
Subject: Re: [PATCH v1] PCI/DPC: Fix AER error logging for DPC/EDR triggered
 events
Message-ID: <20260330222059.GA103174@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875b2f99-35b9-4a7c-b47e-bfdc543ef7a0@linux.intel.com>

On Wed, Mar 18, 2026 at 10:48:07AM -0700, Kuppuswamy Sathyanarayanan wrote:
> On 3/18/2026 10:22 AM, Bjorn Helgaas wrote:
> > On Wed, Mar 18, 2026 at 10:04:49AM -0700, Kuppuswamy Sathyanarayanan wrote:
> >> aer_print_error() skips printing if ratelimit_print[i] is not set.
> >> In the native AER path, ratelimit_print is initialized by
> >> add_error_device() during source device discovery, and is set to 1
> >> for fatal errors to bypass rate limiting since fatal errors should
> >> always be logged.
> >>
> >> The DPC/EDR path uses the DPC-capable port as the error source and
> >> reads its AER uncorrectable error status registers directly in
> >> dpc_get_aer_uncorrect_severity(). Since it does not go through
> >> add_error_device(), ratelimit_print[0] is left uninitialized and zero.
> >> As a result, aer_print_error() silently drops all AER error messages
> >> for DPC/EDR triggered events.
> >>
> >> Set ratelimit_print[0] to 1 to bypass rate limiting and always print
> >> AER logs for fatal errors.

To be precise, I think this bypasses rate limiting for all
uncorrectable errors (both fatal and non-fatal) that cause DPC to be
triggered, i.e., uncorrectable errors detected directly by the DPC
port, right?

Uncorrectable errors detected downstream of the DPC port would
generate ERR_NONFATAL or ERR_FATAL messages.  When the DPC port
receives those, it triggers DPC but logs only the "containment event
... received from" message.  That message isn't ratelimited, and this
patch doesn't change that.  I guess there aren't any AER log details
to log in this case because they're in downstream devices that we
can't read while DPC is triggered.

> >> Fixes: a57f2bfb4a58 ("PCI/AER: Ratelimit correctable and non-fatal error logging")
> >> Co-developed-by: Goudar Manjunath Ramanagouda <manjunath.ramanagouda.goudar@intel.com>
> >> Signed-off-by: Goudar Manjunath Ramanagouda <manjunath.ramanagouda.goudar@intel.com>
> >> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > 
> > I think this does the same as
> > https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/commit/?id=d4d1ecff2c2d
> > which is already queued for v7.1.
> 
> Thanks for the reference.
> 
> Since errors in the DPC path leads to port containment, I think it
> is best to always log them for reference and debug purposes. So I
> think we don't need to export aer_print_init() from the AER driver
> (which can ratelimit non-fatal DPC error). Instead we can by default
> skip ratelimit for DPC errors by initializing ratelimit_print[0] =
> 1.

I think that makes sense.  With Sizhe's patch, the pci_warn() in
dpc_process_error() is not ratelimited but the aer_print_error() part
is, so we always see the "containment event" warning but may not see
the rest.

I guess we only call dpc_get_aer_uncorrect_severity() for the
PCI_EXP_DPC_STATUS_TRIGGER_RSN_UNCOR case; the NFE, FE, and IN_EXT
cases aren't affected by this patch.

I replaced Sizhe's ratelimit patch on pci/dpc with this one, keeping
the patch that holds a reference while calling dpc_process_error().

> >> ---
> >>  drivers/pci/pcie/dpc.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> >> index fc18349614d7..7605ddd9f0ba 100644
> >> --- a/drivers/pci/pcie/dpc.c
> >> +++ b/drivers/pci/pcie/dpc.c
> >> @@ -256,6 +256,7 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
> >>  
> >>  	info->dev[0] = dev;
> >>  	info->error_dev_num = 1;
> >> +	info->ratelimit_print[0] = 1;
> >>  
> >>  	return 1;
> >>  }
> >> -- 
> >> 2.43.0
> >>
> 
> -- 
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
> 

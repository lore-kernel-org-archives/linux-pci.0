Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0DA22652D;
	Tue, 24 Feb 2026 14:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771942576; cv=none; b=MxiTrTh9Y4gW2LMua0KtzY72UUT/ZtZ2d8eJEQqjRdWukwjw6SnybnL0iBtg/F3Xus7mqXf53cD+v366uU+r63KcOd2Ss4tA2mV1P4o1Axzt+SZ8QBHkB3WeUjoXcOTy8XP8TYBt0x/IOZxlwWAN1GN019110bsiDuaJVZ4mCXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771942576; c=relaxed/simple;
	bh=BPhGzAUhjoT6XgL7nw4jhbbYymgyyYKkx6dMOZQroMA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tABg8aDvcXjAUoMALxCUJu6eiEld2DoSuULRzPykWPmXJgD6+oZwe/WN+emPlFYmltlkPJCE4pceGP7kvFvcHihz+0SlDtn8GO5DJ2y60323WuvlfyWxHQfaYumWCEc6PLMy//UH+23L6I3B5BHqivF0lcj41jHLXaRTQXJh4Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 8EBBCB6531;
	Tue, 24 Feb 2026 14:16:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 6D6442000E;
	Tue, 24 Feb 2026 14:16:04 +0000 (UTC)
Date: Tue, 24 Feb 2026 09:16:01 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, linux-rockchip@lists.infradead.org,
 linux-pci@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v4 3/3] PCI: dw-rockchip: Add
 pcie_ltssm_state_transition trace support
Message-ID: <20260224091601.48a7b3c0@fedora>
In-Reply-To: <20260224091115.6e32c38e@fedora>
References: <1769047340-113287-1-git-send-email-shawn.lin@rock-chips.com>
	<1769047340-113287-4-git-send-email-shawn.lin@rock-chips.com>
	<20260224091115.6e32c38e@fedora>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6D6442000E
X-Stat-Signature: cc5i4wxriye491rn8zriqqfuxc8gtdqc
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18AB8ACkvte6gVFtUx8GaJ9v/c3lZVdLqM=
X-HE-Tag: 1771942564-529778
X-HE-Meta: U2FsdGVkX190E3yiyW8l9UUe2SAMJZEOLI06WlmLAik1NFA66P2vOv8OedoL3lBFc9fwc5gFrcDb+qgru7EClOj0yCS7Ve91dl+cxpxcnhv3wDgr4QQJPduntak+FBeIR5NmZfMoKlIDpe2p+W/chneL6zC3+e+qfb5CrPiIXNvcbfVBV+PTIByjNlQi0AcdOYOnC45c5JSdU6jhJXttA+4p/przb6flOvky/rhpOpZVoIQFx60+vxHHgr+g7QSdG7FJgUlA6UQ3Z4i2HmOgqtI6Vl4urc5Tkxb0mAA0Kmf85s2glhhH23ct87AY7n9TwUWVmhuEZSYkJRbZ35MV1Vkdoke9kdRYCnOfvtnJc/pbvMdUb7UMNG4G3yjpfce2

On Tue, 24 Feb 2026 09:11:15 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > +#ifdef CONFIG_TRACING
> > +static void rockchip_pcie_ltssm_trace_work(struct work_struct *work)
> > +{
> > +	struct rockchip_pcie *rockchip = container_of(work,
> > +						struct rockchip_pcie,
> > +						trace_work.work);
> > +	struct dw_pcie *pci = &rockchip->pci;
> > +	enum dw_pcie_ltssm state;
> > +	u32 i, l1ss, prev_val = DW_PCIE_LTSSM_UNKNOWN, rate, val;
> > +
> > +	if (!pci_ltssm_tp_enabled())
> > +		goto skip_trace;  
> 
> You can use:
> 
> 	if (!trace_pcie_ltssm_state_transition_enabled())
> 		goto skip_trace;
> 
> The above is a static branch. That means when tracing is disabled, it is
> basically:
> 
> 	goto skip_trace;
> 
> and when tracing is enabled it is a nop.
> 
> -- Steve
> 
> 
> > +
> > +	for (i = 0; i < PCIE_DBG_LTSSM_HISTORY_CNT; i++) {
> > +		val = rockchip_pcie_readl_apb(rockchip,
> > +				PCIE_CLIENT_DBG_FIFO_STATUS);
> > +		rate = FIELD_GET(PCIE_DBG_FIFO_RATE_MASK, val);
> > +		l1ss = FIELD_GET(PCIE_DBG_FIFO_L1SUB_MASK, val);
> > +		val = FIELD_GET(PCIE_LTSSM_STATUS_MASK, val);
> > +
> > +		/*
> > +		 * Hardware Mechanism: The ring FIFO employs two tracking
> > +		 * counters:
> > +		 * - 'last-read-point': maintains the user's last read position
> > +		 * - 'last-valid-point': tracks the HW's last state update
> > +		 *
> > +		 * Software Handling: When two consecutive LTSSM states are
> > +		 * identical, it indicates invalid subsequent data in the FIFO.
> > +		 * In this case, we skip the remaining entries. The dual counter
> > +		 * design ensures that on the next state transition, reading can
> > +		 * resume from the last user position.
> > +		 */
> > +		if ((i > 0 && val == prev_val) || val > DW_PCIE_LTSSM_RCVRY_EQ3)
> > +			break;
> > +
> > +		state = prev_val = val;
> > +		if (val == DW_PCIE_LTSSM_L1_IDLE) {
> > +			if (l1ss == 2)
> > +				state = DW_PCIE_LTSSM_L1_2;
> > +			else if (l1ss == 1)
> > +				state = DW_PCIE_LTSSM_L1_1;
> > +		}
> > +
> > +		trace_pcie_ltssm_state_transition(dev_name(pci->dev),
> > +				dw_pcie_ltssm_status_string(state),
> > +				((rate + 1) > pci->max_link_speed) ?
> > +				PCI_SPEED_UNKNOWN : PCIE_SPEED_2_5GT + rate);
> > +	}
> > +
> > +skip_trace:
> > +	schedule_delayed_work(&rockchip->trace_work, msecs_to_jiffies(5000));
> > +}
> > +

Hmm, so basically you only want to call the work when tracing is
enabled? That's what I was thinking should be enabled by the reg and
unreg functions. That is, the reg should enabled the delayed work, and
the unreg should disable it from being called.

This looks like it calls the work regardless of if tracing is enabled
or not. Why waste the cycles when tracing is disabled?

-- Steve

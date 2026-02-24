Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39D03A4F2D;
	Tue, 24 Feb 2026 15:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771947998; cv=none; b=b4X/Bqavrb01HE2p5l92PiUsAyHpMCvfKBw5prbNFtS6MDwJHN7zomxme4A4Z+Xicz46ufSnKxtyksuj4wtDcSb6F58V0Ej9/nOiMsH19oES0FmtgEL5M+1MNVxHQtxnvTn1i4lo3IlvgSoihdr34GCCsYzBX0Co70ktj6y8LVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771947998; c=relaxed/simple;
	bh=VYN04sJprWrkFA4cwUj5TgFvwHyMtnyDZDD0bnLfwhg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OGvn90FECBBHQSLmKB3G01kDRsgGg01f2cwxeClZYTwszUnptsy+wPkDfzy7HONmwrb39pcsGx/escMo1BAKjIyQixJLIkTa22RdvR1pkGSBFWj7EIgwj/jkI5Bl4OyrU74d+KUdw4qg545CKkVn62jN1/G5Dnu3zA8SmR5dF3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mIo4opzc; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mIo4opzc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771947996; x=1803483996;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=VYN04sJprWrkFA4cwUj5TgFvwHyMtnyDZDD0bnLfwhg=;
  b=mIo4opzcwr7ihcW9fXzmuojznDpGsooWqjzfjYDZbmVW009LyHvLG2pX
   xI/y291Wvm7e2NCQs40IPBYmBpWoCdm6l7wSYf89izJ+B0KMpQ0jOTvQw
   wb+M0Emzf4rXpSHvhIcq8umrMVa58yKIkvNxNuYQyXJhprJY5LA4t1kAO
   SR+dqoxSpUlXmF0JH2vqfwW/j7/qAK5ZOUnK1qCiNZFe0uowASlT6B4Tf
   8fbZAnOdTnKnkEVbCyQQMbvU+h7yiKnA0KfkMMIRu1TgGFdiwRbVJi+RR
   MbcALzVvZXJgfy77tOIXU4bNaKI+2xDBur9MQMBhoNmJD2D0FRBAdI0t1
   Q==;
X-CSE-ConnectionGUID: H8i4YLzWSYChx7HRxSpjsQ==
X-CSE-MsgGUID: b5a0l/vOQYCRTIzIoQdfuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="90385391"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="90385391"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 07:46:36 -0800
X-CSE-ConnectionGUID: +Wgeobq1QgyikKD6DWFKzw==
X-CSE-MsgGUID: UtSYK39EQ+a8HtZY7FpQHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="215954220"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.133])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 07:46:32 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 24 Feb 2026 17:46:29 +0200 (EET)
To: Manivannan Sadhasivam <mani@kernel.org>
cc: Shawn Lin <shawn.lin@rock-chips.com>, Bjorn Helgaas <bhelgaas@google.com>, 
    linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org, 
    linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
    Steven Rostedt <rostedt@goodmis.org>, 
    Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v4 1/3] PCI: trace: Add PCI controller LTSSM transition
 tracepoint
In-Reply-To: <2sgfbgsgrbztqadhzz6wf6b7j2lmyzmhwugr3tycsjeaik5xdz@ncehsafpi2y5>
Message-ID: <75b206bb-7fcd-2f59-4181-1839ba5aa8e4@linux.intel.com>
References: <1769047340-113287-1-git-send-email-shawn.lin@rock-chips.com> <1769047340-113287-2-git-send-email-shawn.lin@rock-chips.com> <7d195f03-978a-2d0d-acdf-e583e68377f2@linux.intel.com> <2sgfbgsgrbztqadhzz6wf6b7j2lmyzmhwugr3tycsjeaik5xdz@ncehsafpi2y5>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-630235247-1771947989=:1751"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-630235247-1771947989=:1751
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 24 Feb 2026, Manivannan Sadhasivam wrote:

> On Tue, Feb 24, 2026 at 05:22:35PM +0200, Ilpo J=C3=A4rvinen wrote:
> > On Thu, 22 Jan 2026, Shawn Lin wrote:
> >=20
> > > Some platforms may provide LTSSM trace functionality, recording histo=
rical
> > > LTSSM state transition information. This is very useful for debugging=
, such
> > > as when certain devices cannot be recognized or link broken during te=
st.
> > > Implement the pci controller tracepoint for recording LTSSM and rate.
> > >=20
> > > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> > > ---
> > >=20
> > > Changes in v4:
> > > - use TRACE_EVENT_FN to notify when to start and stop the tracepoint,
> > >   and export pci_ltssm_tp_enabled() for host drivers to use
> > >=20
> > > Changes in v3:
> > > - add TRACE_DEFINE_ENUM for all enums(Steven Rostedt)
> > >=20
> > > Changes in v2: None
> > >=20
> > >  drivers/pci/trace.c                   | 20 ++++++++++++
> > >  include/linux/pci.h                   |  4 +++
> > >  include/trace/events/pci_controller.h | 57 +++++++++++++++++++++++++=
++++++++++
> > >  3 files changed, 81 insertions(+)
> > >  create mode 100644 include/trace/events/pci_controller.h
> > >=20
> > > diff --git a/drivers/pci/trace.c b/drivers/pci/trace.c
> > > index cf11abc..d351a51 100644
> > > --- a/drivers/pci/trace.c
> > > +++ b/drivers/pci/trace.c
> > > @@ -9,3 +9,23 @@
> > > =20
> > >  #define CREATE_TRACE_POINTS
> > >  #include <trace/events/pci.h>
> > > +#include <trace/events/pci_controller.h>
> > > +
> > > +static atomic_t pcie_ltssm_tp_enabled =3D ATOMIC_INIT(0);
> > > +
> > > +bool pci_ltssm_tp_enabled(void)
> > > +{
> > > +=09return atomic_read(&pcie_ltssm_tp_enabled) > 0;
> > > +}
> > > +EXPORT_SYMBOL(pci_ltssm_tp_enabled);
> > > +
> > > +int pci_ltssm_tp_reg(void)
> > > +{
> > > +=09atomic_inc(&pcie_ltssm_tp_enabled);
> > > +=09return 0;
> > > +}
> > > +
> > > +void pci_ltssm_tp_unreg(void)
> > > +{
> > > +=09atomic_dec(&pcie_ltssm_tp_enabled);
> > > +}
> > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > index e7cb527..ac25a3e 100644
> > > --- a/include/linux/pci.h
> > > +++ b/include/linux/pci.h
> > > @@ -2770,6 +2770,10 @@ static inline struct eeh_dev *pci_dev_to_eeh_d=
ev(struct pci_dev *pdev)
> > >  }
> > >  #endif
> > > =20
> > > +#ifdef CONFIG_TRACING
> > > +bool pci_ltssm_tp_enabled(void);
> > > +#endif
> > > +
> > >  void pci_add_dma_alias(struct pci_dev *dev, u8 devfn_from, unsigned =
nr_devfns);
> > >  bool pci_devs_are_dma_aliases(struct pci_dev *dev1, struct pci_dev *=
dev2);
> > >  int pci_for_each_dma_alias(struct pci_dev *pdev,
> > > diff --git a/include/trace/events/pci_controller.h b/include/trace/ev=
ents/pci_controller.h
> > > new file mode 100644
> > > index 0000000..db4a960
> > > --- /dev/null
> > > +++ b/include/trace/events/pci_controller.h
> > > @@ -0,0 +1,57 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#undef TRACE_SYSTEM
> > > +#define TRACE_SYSTEM pci_controller
> >=20
> > I find putting this into "pci_controller" little odd as LTSSM is relate=
d=20
> > to PCIe links/ports. To me looks something that belongs to the existing=
=20
> > include/trace/events/pci.h.
>=20
> I suggested 'pci_controller.h' since these tracepoints are only going to =
be used
> by the controller drivers. Putting it under 'pci.h' will imply that these=
 can be
> used by the client drivers also.

PCIe r7 spec has Flit Performance Measurement Extended Capability that=20
seems to have something for LTSSM tracking and those seem more generic=20
than just for controllers (I've not spent much time on trying to fully=20
understand those capabilities, just recalled seeing them earlier).

--
 i.

> > > +#if !defined(_TRACE_HW_EVENT_PCI_CONTROLLER_H) || defined(TRACE_HEAD=
ER_MULTI_READ)
> > > +#define _TRACE_HW_EVENT_PCI_CONTROLLER_H
> > > +
> > > +#include <uapi/linux/pci_regs.h>
> > > +#include <linux/tracepoint.h>
> > > +
> > > +TRACE_DEFINE_ENUM(PCIE_SPEED_2_5GT);
> > > +TRACE_DEFINE_ENUM(PCIE_SPEED_5_0GT);
> > > +TRACE_DEFINE_ENUM(PCIE_SPEED_8_0GT);
> > > +TRACE_DEFINE_ENUM(PCIE_SPEED_16_0GT);
> > > +TRACE_DEFINE_ENUM(PCIE_SPEED_32_0GT);
> > > +TRACE_DEFINE_ENUM(PCIE_SPEED_64_0GT);
> > > +TRACE_DEFINE_ENUM(PCI_SPEED_UNKNOWN);
> > > +
> > > +extern int pci_ltssm_tp_reg(void);
> > > +extern void pci_ltssm_tp_unreg(void);
> > > +
> > > +TRACE_EVENT_FN(pcie_ltssm_state_transition,
> > > +=09TP_PROTO(const char *dev_name, const char *state, u32 rate),
> > > +=09TP_ARGS(dev_name, state, rate),
> > > +
> > > +=09TP_STRUCT__entry(
> > > +=09=09__string(dev_name, dev_name)
> > > +=09=09__string(state, state)
> > > +=09=09__field(u32, rate)
> > > +=09),
> > > +
> > > +=09TP_fast_assign(
> > > +=09=09__assign_str(dev_name);
> > > +=09=09__assign_str(state);
> > > +=09=09__entry->rate =3D rate;
> > > +=09),
> > > +
> > > +=09TP_printk("dev: %s state: %s rate: %s",
> > > +=09=09__get_str(dev_name), __get_str(state),
> > > +=09=09__print_symbolic(__entry->rate,
> > > +=09=09=09{ PCIE_SPEED_2_5GT,  "2.5 GT/s" },
> > > +=09=09=09{ PCIE_SPEED_5_0GT,  "5.0 GT/s" },
> > > +=09=09=09{ PCIE_SPEED_8_0GT,  "8.0 GT/s" },
> > > +=09=09=09{ PCIE_SPEED_16_0GT, "16.0 GT/s" },
> > > +=09=09=09{ PCIE_SPEED_32_0GT, "32.0 GT/s" },
> > > +=09=09=09{ PCIE_SPEED_64_0GT, "64.0 GT/s" },
> > > +=09=09=09{ PCI_SPEED_UNKNOWN, "Unknown" }
> >=20
> > Why are these done inline instead of using EM/EMe()? Or simply with
> > pci_speed_string()?
> >=20
> >=20
> > Unrelated to this, sadly I failed to notice Shuai's version of=20
> > pcie_link_event() did not translate link speeds (my own version used=20
> > pci_speed_string()).
> >=20
> > > +=09=09)
> > > +=09),
> > > +
> > > +=09pci_ltssm_tp_reg, pci_ltssm_tp_unreg
> > > +);
> > > +
> > > +#endif /* _TRACE_HW_EVENT_PCI_CONTROLLER_H */
> > > +
> > > +/* This part must be outside protection */
> > > +#include <trace/define_trace.h>
> > >=20
> >=20
> > --=20
> >  i.
> >=20
>=20
>=20

--=20
 i.

--8323328-630235247-1771947989=:1751--

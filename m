Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43895 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754485Ab1LGXL5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Dec 2011 18:11:57 -0500
Received: by ghbz2 with SMTP id z2so995321ghb.19
        for <linux-pci@vger.kernel.org>; Wed, 07 Dec 2011 15:11:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4EDFCB4A.60106@redhat.com>
References: <CAErSpo58okGsDW4dOK4i0g_RUejkuQa=iw2uQ5HAJJZCwFtsbw@mail.gmail.com>
	<20111007232516.GF2980@ram-ThinkPad-T61>
	<1318057168.29415.333.camel@pasglop>
	<20111008075353.GK2980@ram-ThinkPad-T61>
	<1318060793.29415.347.camel@pasglop>
	<20111102140325.004b9dad@jbarnes-desktop>
	<20111103013014.GB393@ram-ThinkPad-T61>
	<20111106023310.GA2383@ram-ThinkPad-T61>
	<20111205103202.29faf6e1@jbarnes-desktop>
	<CAE9FiQXx_nkOFP2S=hXKyjcFHh4R4f5c+J-aCiDoYS=3Tgdmqw@mail.gmail.com>
	<20111207092531.GF19129@ram-ThinkPad-T61>
	<4EDFCB4A.60106@redhat.com>
Date: Wed, 7 Dec 2011 15:11:56 -0800
Message-ID: <CAE9FiQXOhn2HkqCh3DiSNUw7RwgAAk2Xe62z11AB=L+pcG__Qg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1]PCI: defer enablement of SRIOV BARS
From: Yinghai Lu <yinghai@kernel.org>
To: Don Dutile <ddutile@redhat.com>
Cc: Ram Pai <linuxram@us.ibm.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Nishanth Aravamudan <nacc@us.ibm.com>, prarit@redhat.com,
	brking@linux.vnet.ibm.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 7, 2011 at 12:23 PM, Don Dutile <ddutile@redhat.com> wrote:
> why not something more explicit like:
>
>        for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
>                if ((i >=  PCI_IOV_RESOURCES) && (i <= PCI_IOV_RESOURCE_END))
>                        continue; /* skip sriov related resources */
>
>                if (dev->resource[i].flags & flags)
>                        bars |= (1 << i);
>        }

no, we should not put checking in the loop.

also you will have problem when CONFIG_PCI_IOV is not defined.

Thanks

Yinghai

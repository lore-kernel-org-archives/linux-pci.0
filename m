Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 7 Dec 2011 22:16:40 +0800
Message-ID: <CAJULonj9rFDKNCzpEXj2r3XjkYojy-CGYpVQ1RF8SxwLVrXqAA@mail.gmail.com>
Subject: =?UTF-8?Q?=E3=80=90Question=E3=80=91Whether_it=27s_legal_to_enable_same_phys?=
	=?UTF-8?Q?ical_DMA_memory_mapped_for_different_NIC_device=3F?=
From: "ustc.mail" <backyes@mail.ustc.edu.cn>
To: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear all,

In NIC driver, to eliminate the  overhead of dma_map_single() for DMA
packet data,  we have statically allocated huge DMA memory buffer ring
at once instead of calling dma_map_single() per packet.  Considering
to further reduce the copy overhead between different NIC(port) ring
while forwarding, one packet from a input NIC(port) will be
transferred to output NIC(port) with no any copy action.

To satisfy this requirement, the packet memory should be mapped into
input port and unmapped when leaving input port, then mapped into
output port and unmapped later.

Whether it's legal to map the same DMA memory into input and output
port simultaneously? If it's not, then the zero-copy for packet
forwarding is not feasible?

Hope PCI expert to post your suggestion.

Thanks!

--Yanfei


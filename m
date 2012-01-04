Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20120103203357.GD17472@phenom.dumpdata.com>
References: <CAJULonj9rFDKNCzpEXj2r3XjkYojy-CGYpVQ1RF8SxwLVrXqAA@mail.gmail.com>
	<20120103203357.GD17472@phenom.dumpdata.com>
Date: Wed, 4 Jan 2012 10:44:11 +0800
Message-ID: <CAJULongKix3QXmcoUcraQxCyLN0wz6oe6p5Efg2A7S_r3nO6Fg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=E3=80=90Question=E3=80=91Whether_it=27s_legal_to_enable_same_?=
	=?UTF-8?Q?physical_DMA_memory_mapped_for_different_NIC_device=3F?=
From: Yanfei Wang <backyes@mail.ustc.edu.cn>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 4, 2012 at 4:33 AM, Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
> On Wed, Dec 07, 2011 at 10:16:40PM +0800, ustc.mail wrote:
>> Dear all,
>>
>> In NIC driver, to eliminate the  overhead of dma_map_single() for DMA
>> packet data,  we have statically allocated huge DMA memory buffer ring
>> at once instead of calling dma_map_single() per packet.  Considering
>> to further reduce the copy overhead between different NIC(port) ring
>> while forwarding, one packet from a input NIC(port) will be
>> transferred to output NIC(port) with no any copy action.
>>
>> To satisfy this requirement, the packet memory should be mapped into
>> input port and unmapped when leaving input port, then mapped into
>> output port and unmapped later.
>>
>> Whether it's legal to map the same DMA memory into input and output
>> port simultaneously? If it's not, then the zero-copy for packet
>> forwarding is not feasible?
>>
>
> Did you ever a get a response about this?
No.
>
> Is the output/input port on a seperate device function? Or is it
> just a specific MMIO BAR in your PCI device?
>
Platform: x86, intel nehalem 8Core NUMA, linux 2.6.39, 10G
82599NIC(two ports per NIC card);
Function: Forwarding packets between different ports.
Targets: Forwarding packets with Zero-Overhead, despite other obstacles.

--Yanfei
>> Hope PCI expert to post your suggestion.
>>
>> Thanks!
>>
>> --Yanfei
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arch" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


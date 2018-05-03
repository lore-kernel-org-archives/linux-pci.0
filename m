Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v2 08/10] PCI: Deprecate of_pci_get_host_bridge_resources()
To: Christoph Hellwig <hch@infradead.org>
References: <cover.1525067324.git.jan.kiszka@siemens.com>
 <aca0d89cd8c1551a83b87ffab29fcd6e1d59a61c.1525067324.git.jan.kiszka@siemens.com>
 <20180502123923.GA10783@infradead.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <b13dd4b5-61c4-3acb-c194-3e448cb8b3d2@siemens.com>
Date: Thu, 3 May 2018 09:53:58 +0200
MIME-Version: 1.0
In-Reply-To: <20180502123923.GA10783@infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-05-02 14:39, Christoph Hellwig wrote:
> On Mon, Apr 30, 2018 at 07:48:42AM +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> There are no in-tree users remaining, all are converted to the managed
>> variant. And it is unlikely that any out-of-tree user got the resource
>> management right as well. So deprecate the interface and push users to
>> the managed version instead.
>>
>> To avoid raising a warning when exporting a deprecated symbol, wrap the
>> API with an inline and export an internal name.
> 
> Don't deprecated it, just remove it.
> 

I see a clear favorite now: consider this patch obsolete. I'll send a
separate removal patch, or a v3 of this series when otherwise needed.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

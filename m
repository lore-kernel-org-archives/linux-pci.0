Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20171018092639.GD14820@red-moon>
References: <1506448161-30961-1-git-send-email-kdinh@apm.com>
 <CAAsHzqv-oQVNm-pNP4Q1KmiSmjaiFx1S4j8uCnij53Te3h8KKg@mail.gmail.com>
 <20171017133807.GB948@red-moon>
 <CAAsHzqsxMy8On5ThggTwYohqMCLEJTbA=b1LgUPiuKu9C+eHeQ@mail.gmail.com>
 <20171018092639.GD14820@red-moon>
From: Khuong Dinh <kdinh@apm.com>
Date: Wed, 18 Oct 2017 14:43:10 -0700
Message-ID: <CAAsHzqvrdq91MQy2zuwzogZMOnf6zXs7XEeT1_++E5VssY-f3A@mail.gmail.com>
Subject: Re: [PATCH v4 pci 0/2] PCI/MSI: pci-xgene-msi: Enable MSI support in
 ACPI boot for X-Gene v1
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: rjw@rjwysocki.net, Marc Zyngier <marc.zyngier@arm.com>,
 linux-pci@vger.kernel.org, msalter@redhat.com, patches <patches@apm.com>,
 linux-kernel@vger.kernel.org, jcm@redhat.com,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,


On Wed, Oct 18, 2017 at 2:26 AM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> [removed unintended disclaimer]
>
> On Tue, Oct 17, 2017 at 10:45:35PM -0700, Khuong Dinh wrote:
>> Hi Lorenzo,
>>
>> On Tue, Oct 17, 2017 at 6:38 AM, Lorenzo Pieralisi
>> <lorenzo.pieralisi@arm.com> wrote:
>> > Hi Khuong,
>> >
>> > On Mon, Oct 16, 2017 at 02:19:50PM -0700, Khuong Dinh wrote:
>> >> Hi Lorenzo,
>> >>   Do you have any comments for this patch?
>> >
>> > I'd have some comments but given that there are related issues with ACPI
>> > probe ordering that Marc is trying to solve on his side - I will work
>> > with him to see if we can accommodate changes that can solve this issue
>> > too.
>> >
>> > Again - I recognize it is a complex problem (that is not even
>> > contemplated by the current ACPI specs), we have to try to make
>> > the solution as generic as we can to prevent reinventing the wheel
>> > anytime a sligthly different issue (related to ACPI probe ordering)
>> > comes up.
>> >
>> > Leave it to me (us) and I will get back to you on this.
>>
>> Thanks for helping to take care of the generic ACPI probe ordering issue.
>> Given that the patch 'PCI/MSI: pci-xgene-msi: Enable MSI support in ACPI
>> boot for X-Gene v1" adds only the ACPI ID, can you pull in this patch
>> independently from the ACPI probe ordering issue?
>
> No. For two reasons:
>
> 1) It's Bjorn who decides whether that code can be merged or not, not me
> 2) That patch sneaks in ACPI MSI support for X-gene v1 that depends on
>    kernel link ordering. As soon as it is pulled in the mainline it
>    creates a dependency on pseudo-working code that may break anytime
>    and as I said many times before I am not willing to rely on that.

Thanks for your information. I got it.
I look forward to hearing your updated information about this generic
ACPI probe ordering issue.


> Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Return-Path: <SRS0=oqaM=32=google.com=bhelgaas@kernel.org>
Return-Path: <SRS0=oqaM=32=google.com=bhelgaas@kernel.org>
MIME-Version: 1.0
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612B41C8C518@IRSMSX102.ger.corp.intel.com>
References: <1488810076-3754-1-git-send-email-elena.reshetova@intel.com>
 <1488810076-3754-18-git-send-email-elena.reshetova@intel.com>
 <20170306213829.GB5305@bhelgaas-glaptop.roam.corp.google.com>
 <20170307115808.16f5235e@xeon-e3> <2236FBA76BA1254E88B949DDB74E612B41C8C518@IRSMSX102.ger.corp.intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 18 Apr 2017 09:05:22 -0500
Message-ID: <CAErSpo4SauhAXm+twpUQVcX7822QdnC=obv7g6oOs_eEh9JOUA@mail.gmail.com>
Subject: Re: [PATCH 17/29] drivers, pci: convert hv_pci_dev.refs from atomic_t
 to refcount_t
To: "Reshetova, Elena" <elena.reshetova@intel.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Stephen Hemminger <sthemmin@microsoft.com>, Kees Cook <keescook@chromium.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, Hans Liljestrand <ishkamiel@gmail.com>,
	David Windsor <dwindsor@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 18, 2017 at 5:40 AM, Reshetova, Elena
<elena.reshetova@intel.com> wrote:
>
>
>> On Mon, 6 Mar 2017 15:38:29 -0600
>> Bjorn Helgaas <helgaas@kernel.org> wrote:
>>
>> > [+cc Hyper-V folks, -cc others]
>> >
>> > On Mon, Mar 06, 2017 at 04:21:04PM +0200, Elena Reshetova wrote:
>> > > refcount_t type and corresponding API should be
>> > > used instead of atomic_t when the variable is used as
>> > > a reference counter. This allows to avoid accidental
>> > > refcounter overflows that might lead to use-after-free
>> > > situations.
>> > >
>> > > Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
>> > > Signed-off-by: Hans Liljestrand <ishkamiel@gmail.com>
>> > > Signed-off-by: Kees Cook <keescook@chromium.org>
>> > > Signed-off-by: David Windsor <dwindsor@gmail.com>
>>
>>
>> Reviewed-by: Stephen Hemminger <sthemmin@microsoft.com>
>
> Getting back on this: could you take the patch via your tree or should I resubmit to some dedicated place with a new review-by added?

Sorry, for some reason I had assumed this would all go as part of the
larger series.  I applied it to my pci/host-hv branch with Stephen's
reviewed-by for v4.12.

Thanks for the ping!

Bjorn

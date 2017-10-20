Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6348630.r2z9ev4yl2@avalon>
References: <1508167134-6243-1-git-send-email-bhumirks@gmail.com>
 <1985905.z83BJQzMUS@avalon> <20171019140657.GA22233@lst.de> <6348630.r2z9ev4yl2@avalon>
From: Bhumika Goyal <bhumirks@gmail.com>
Date: Fri, 20 Oct 2017 10:13:11 +0200
Message-ID: <CAOH+1jFxhiF8j6MM9txfcs1SHOAuYihq=GZWmVb+wUR5aUCsnQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/15] usb: gadget: make config_item_type structures const
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Christoph Hellwig <hch@lst.de>,
        Julia Lawall <julia.lawall@lip6.fr>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        dledford@redhat.com, sean.hefty@intel.com,
        Hal Rosenstock <hal.rosenstock@gmail.com>, sagi@grimberg.me,
        kishon@ti.com, Bjorn Helgaas <bhelgaas@google.com>,
        nab@linux-iscsi.org, balbi@kernel.org,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Joel Becker <jlbec@evilplan.org>, ccaulfie@redhat.com,
        teigland@redhat.com, mfasheh@versity.com,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-usb@vger.kernel.org,
        cluster-devel@redhat.com, ocfs2-devel@oss.oracle.com,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 19, 2017 at 5:05 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Christoph,
>
> On Thursday, 19 October 2017 17:06:57 EEST Christoph Hellwig wrote:
>> > Now we have 9 const instances of the config_item_type structure that are
>> > identical, with only the .ct_owner field set. Should they be all merged
>> > into a single structure ?
>>
>> I think that's a good idea.
>>
>> But I'm about to slurp up this whole series into my tree, how about making
>> that an incremental patch?
>
> I'm fine with that.
>
> Bhumika, would you like to submit an incremental patch, or should I do it ?
>

I will submit a patch for merging these structures.
But should I make a separate patch for this particular change or send
a v3 for the whole series?

Thanks,
Bhumika

> --
> Regards,
>
> Laurent Pinchart
>

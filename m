Return-Path: <SRS0=Wmv6=3W=google.com=bhelgaas@kernel.org>
Return-Path: <SRS0=Wmv6=3W=google.com=bhelgaas@kernel.org>
MIME-Version: 1.0
In-Reply-To: <76b74ad0-0c7f-a366-89d6-dc87ac315bc5@codeaurora.org>
References: <1491627351-1111-1-git-send-email-okaya@codeaurora.org>
 <1491627351-1111-4-git-send-email-okaya@codeaurora.org> <20170413204800.GB28316@bhelgaas-glaptop.roam.corp.google.com>
 <20170413210218.GA24910@bhelgaas-glaptop.roam.corp.google.com> <76b74ad0-0c7f-a366-89d6-dc87ac315bc5@codeaurora.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 13 Apr 2017 20:30:54 -0500
Message-ID: <CAErSpo6OgQODbJGAyVRp5Y7ifDjmmvRtVbXKbGXBJcYsQJr9OQ@mail.gmail.com>
Subject: Re: [PATCH V8 3/5] PCI/ASPM: add init hook to device_add
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "Patel, Mayurkumar" <mayurkumar.patel@intel.com>,
	David Daney <david.daney@cavium.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Julia Lawall <Julia.Lawall@lip6.fr>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>, Rajat Jain <rajatja@google.com>,
	linux-arm <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 13, 2017 at 8:19 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 4/13/2017 5:02 PM, Bjorn Helgaas wrote:
>> I do see that you change the deallocation in patch [5/5], but I think
>> the deallocation change should be in the same patch as the allocation
>> change.  Otherwise I think we have a use-after-free problem in this
>> sequence:
>
> Sure, I'll reorder. As you can see here, link will be only removed if
> root port is being removed.
>
> Without this, we'll hit the use after free issue you mentioned.
>
>         if (pdev->has_secondary_link) {
>                 link = pdev->link_state;
>                 down_read(&pci_bus_sem);
>                 mutex_lock(&aspm_lock);
>
>                 list_del(&link->sibling);
>                 list_del(&link->link);
>
>                 /* Clock PM is for endpoint device */
>                 free_link_state(link);
>                 mutex_unlock(&aspm_lock);
>                 up_read(&pci_bus_sem);
>                 return;
>         }

Right, but this "pdev->has_secondary_link" check is in your new code
and doesn't show up until patch [5/5].

As of *this* patch [3/5], the link is removed when the endpoint is
removed, so we could hit the use-after-free.

Granted, we'll only be susceptible to this while bisecting because
normally all the patches will be applied.  But I think this patch will
make more sense and be easier to review if it makes the link_state
lifetime match the Port's lifetime.

Bjorn

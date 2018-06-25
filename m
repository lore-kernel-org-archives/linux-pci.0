Return-Path: <SRS0=O44p=JL=linuxfoundation.org=gregkh@kernel.org>
Return-Path: <SRS0=O44p=JL=linuxfoundation.org=gregkh@kernel.org>
Date: Mon, 25 Jun 2018 14:41:10 +0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pingfan Liu <kernelfans@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Christoph Hellwig <hch@infradead.org>,
	Bjorn Helgaas <helgaas@kernel.org>, Dave Young <dyoung@redhat.com>,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] drivers/base: introduce some help routines for
 reordering a group of dev
Message-ID: <20180625064110.GA4233@kroah.com>
References: <1529904187-18673-1-git-send-email-kernelfans@gmail.com>
 <1529904187-18673-2-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1529904187-18673-2-git-send-email-kernelfans@gmail.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 25, 2018 at 01:23:05PM +0800, Pingfan Liu wrote:
> This patch introduce some help routines used by next patch. It aims to
> ease reviewing, while the next patch will concentrate on algorithm.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> ---
>  drivers/base/core.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 36622b5..8113d2c 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -123,6 +123,44 @@ static int device_is_dependent(struct device *dev, void *target)
>  	return ret;
>  }
>  
> +struct pos_info {
> +	struct device *pos;
> +	struct device *tail;
> +};
> +
> +/* caller takes the devices_kset->list_lock */
> +static int descendants_reorder_after_pos(struct device *dev,
> +	void *data)
> +{
> +	struct device *pos;
> +	struct pos_info *p = data;
> +
> +	pos = p->pos;
> +	pr_debug("devices_kset: Moving %s after %s\n",
> +		 dev_name(dev), dev_name(pos));
> +	device_for_each_child(dev, p, descendants_reorder_after_pos);
> +	/* children at the tail */
> +	list_move(&dev->kobj.entry, &pos->kobj.entry);
> +	/* record the right boundary of the section */
> +	if (p->tail == NULL)
> +		p->tail = dev;
> +	return 0;
> +}
> +
> +/* iterate over an open section */
> +#define list_opensect_for_each_reverse(cur, left, right)	\
> +	for (cur = right->prev; cur == left; cur = cur->prev)
> +
> +static bool is_consumer(struct device *query, struct device *supplier)
> +{
> +	struct device_link *link;
> +	/* todo, lock protection */
> +	list_for_each_entry(link, &supplier->links.consumers, s_node)
> +		if (link->consumer == query)
> +			return true;
> +	return false;
> +}

You are adding code that no one uses yet, making this impossible to
review as I don't know what to expect.  I shouldn't have to read the
second patch and have to flip back and forth to try to figure it out :(

sorry, please break this series up in a better way to make it simpler to
review.

greg k-h
